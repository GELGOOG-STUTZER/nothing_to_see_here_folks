%{
#include <iostream>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/Instructions.h"


#include <vector>
#include <stack>  
#define YYSTYPE llvm::Value*
extern "C" {
    int yyparse();
    int yylex();
    void yyerror(char *s) {
        std::cerr << s << "\n";
    }
    int yywrap(void){return 1;}
}

llvm::LLVMContext context;
llvm::IRBuilder<>* builder;
llvm::Module* module;
llvm::Function *func_cur;
std::vector<std::vector<std::pair<llvm::Value*, llvm::Value*>>> variables;
llvm::BasicBlock * gcondF;

typedef struct {
    llvm::GlobalVariable* val_ir;
    int val_real;
} value_t;

std::map<std::string, value_t> value_map;
std::stack<llvm::BasicBlock *> BB_while_cond;
std::stack<llvm::BasicBlock *> BB_while_false;
std::stack<llvm::Value* > for_counter;

typedef struct {
    llvm::GlobalVariable* val_ir;
    int size;
    int val_init;
    int* val_real;
} array_t;

typedef struct {
    llvm::GlobalVariable* val_ir;
    int sizei;
    int sizej;
    int val_init;
    int* val_real;
} array2_t;

std::map<std::string, array_t> array_map;
std::map<std::string, array2_t> array2_map;

std::stack<int> func_params_count;
std::stack<std::vector<llvm::Value *>> func_params_val;
std::map<std::string, llvm::BasicBlock *> BB_map;

int main(int argc, char **argv)
{
    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmPrinter();

    module = new llvm::Module("noname", context);
    builder = new llvm::IRBuilder<> (context);

    llvm::FunctionType *funcType = llvm::FunctionType::get(builder->getVoidTy(), false);
    llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z12window_clearv", module);
    llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z11check_eventv", module);
    llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z5flushv", module);

    funcType = llvm::FunctionType::get(builder->getVoidTy(), builder->getInt32Ty(), false);
    llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "print", module);

    funcType = llvm::FunctionType::get(builder->getVoidTy(), {builder->getInt32Ty(), builder->getInt32Ty()}, false);
    llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z11init_windowjj", module);

    funcType = llvm::FunctionType::get(builder->getVoidTy(), {builder->getInt32Ty(), builder->getInt32Ty(), builder->getInt32Ty()}, false);
    llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "put_pixel", module);

    yyparse();

    llvm::outs() << "#[LLVM IR]:\n";
    module->print(llvm::outs(), nullptr);
    return 0;
}
%}

%token TINTEGER
%token TIDENTIFIER
%token TIF
%token TWHILE
%token TFOR
%token TSTART
%token TFINISH
%token TTYPE
%token TRETURN
%token TEQUAL
%token TCEQ
%token TCNE
%token TCLT
%token TCLE
%token TCGT
%token TCGE
%token TLPAREN
%token TRPAREN
%token TLBRACE
%token TRBRACE
%token TDOT
%token TCOMMA
%token TGOTO
%token WINDOW_CLEAR
%token CHECK_EVENT
%token FLUSH
%token INIT_WINDOW
%token PUT_PIXEL
%token PRINT


%%

Parse: PROGRAM {YYACCEPT;}

PROGRAM: ROUTINE_DECLARE            {}
         | VARIABLE_DECLARE         {} 
         | PROGRAM VARIABLE_DECLARE {}
         | PROGRAM ROUTINE_DECLARE  {}


VARIABLE_DECLARE : TTYPE TIDENTIFIER TEQUAL TINTEGER ';' {
                                                    module->getOrInsertGlobal((char*)$2, builder->getInt32Ty());
                                                    module->getNamedGlobal((char*)$2)->setLinkage(llvm::GlobalVariable::InternalLinkage);
                                                    module->getNamedGlobal((char*)$2)->setInitializer(llvm::ConstantInt::get(builder->getInt32Ty(), 0));
                                                    module->getNamedGlobal((char*)$2)->setConstant(false);
                                                    value_t val;
                                                    val.val_ir = module->getNamedGlobal((char*)$2);
                                                    val.val_real = atoi((char*)$4);
                                                    value_map.insert({(char*)$2, val});
                                                }
                    | TTYPE TIDENTIFIER '[' TINTEGER ']'';' {
                                                    int size = atoi((char*)$4);
                                                    llvm::ArrayType *arrayType = llvm::ArrayType::get(builder->getInt32Ty(), size);
                                                    module->getOrInsertGlobal((char*)$2, arrayType);
                                                    module->getNamedGlobal((char*)$2)->setLinkage(llvm::GlobalVariable::InternalLinkage);
                                                    module->getNamedGlobal((char*)$2)->setInitializer(module->getNamedGlobal((char*)$2)->getNullValue(arrayType));
                                                    module->getNamedGlobal((char*)$2)->setConstant(false);

                                                    array_t arr;
                                                    arr.val_ir = module->getNamedGlobal((char*)$2);
                                                    arr.size = size;
                                                    arr.val_init = 0;
                                                    array_map.insert({(char*)$2, arr});
                                                }
                    | TTYPE TIDENTIFIER '[' TINTEGER ']' '[' TINTEGER ']' ';' {
                                                    int sizei = atoi((char*)$4);
                                                    int sizej = atoi((char*)$7);

                                                    llvm::ArrayType *arrayType = llvm::ArrayType::get(llvm::ArrayType::get(builder->getInt32Ty(), sizej), sizei);
                                                    module->getOrInsertGlobal((char*)$2, arrayType);
                                                    module->getNamedGlobal((char*)$2)->setLinkage(llvm::GlobalVariable::InternalLinkage);
                                                    module->getNamedGlobal((char*)$2)->setInitializer(module->getNamedGlobal((char*)$2)->getNullValue(arrayType));
                                                    module->getNamedGlobal((char*)$2)->setConstant(false);

                                                    array2_t arr;
                                                    arr.val_ir = module->getNamedGlobal((char*)$2);
                                                    arr.sizei = sizei;
                                                    arr.sizej = sizej;
                                                    array2_map.insert({(char*)$2, arr});
                                                }

PARAMETERS : %empty                            { func_params_count.push(0); }
         | TTYPE TIDENTIFIER                   { func_params_count.push(1); func_params_val.push({$2}); }
         | PARAMETERS TCOMMA TTYPE TIDENTIFIER { int k = func_params_count.top(); func_params_count.pop(); func_params_count.push(k+1); func_params_val.top().push_back($4); }

EXT_WINDOW_CLEAR : WINDOW_CLEAR TLPAREN EXPRESSION TRPAREN {
    auto window_clear = module->getFunction("_Z12window_clearv");
    builder->CreateCall(window_clear);
}

EXT_CHECK_EVENT : CHECK_EVENT TLPAREN EXPRESSION TRPAREN {
    auto check_event = module->getFunction("_Z11check_eventv");
    builder->CreateCall(check_event);
}

EXT_FLUSH : FLUSH TLPAREN EXPRESSION TRPAREN {
    auto flush = module->getFunction("_Z5flushv");
    builder->CreateCall(flush);
}

EXT_INIT_WINDOW : INIT_WINDOW TLPAREN EXPRESSION TCOMMA EXPRESSION TRPAREN {
    auto init_window = module->getFunction("_Z11init_windowjj");
    builder->CreateCall(init_window, {$3, $5});
}

EXT_PUT_PIXEL : PUT_PIXEL TLPAREN EXPRESSION TCOMMA EXPRESSION TCOMMA EXPRESSION TRPAREN {
    auto put_pixel = module->getFunction("put_pixel");
    builder->CreateCall(put_pixel, {$3, $5, $7});
}

EXT_PRINT : PRINT TLPAREN EXPRESSION TRPAREN {
    auto print = module->getFunction("print");
    builder->CreateCall(print, $3);
}

LABEL: TIDENTIFIER ':' {
                                                    if (BB_map.find((char*)$1) == BB_map.end()) {
                                                        BB_map.insert({(char*)$1, llvm::BasicBlock::Create(context, "", func_cur)});
                                                    }
                                                    llvm::BasicBlock *BB = BB_map[(char*)$1];
                                                    builder->CreateBr(BB);
                                                    builder->SetInsertPoint(BB);
}

GOTO: TGOTO TIDENTIFIER ';' {
                                                    if (BB_map.find((char*)$2) == BB_map.end()) {
                                                        BB_map.insert({(char*)$2, llvm::BasicBlock::Create(context, "", func_cur)});
                                                    }
                                                    llvm::BasicBlock *BB = BB_map[(char*)$2];
                                                    builder->CreateBr(BB);
}

ROUTINE_DECLARE : TTYPE TIDENTIFIER TLPAREN PARAMETERS TRPAREN TLBRACE {
                                                    llvm::Function *func = module->getFunction((char*)$2);
                                                    if (func == nullptr) {
                                                        int tt = 0;
                                                        tt = func_params_count.top();
                                                        std::vector <llvm::Type*> vparams = {};
                                                        for (int ttt = 0; ttt < tt; ttt++)
                                                        {
                                                            vparams.push_back(builder->getInt32Ty());
                                                        }
                                                        llvm::FunctionType *funcType;
                                                            funcType = llvm::FunctionType::get(builder->getVoidTy(), llvm::ArrayRef<llvm::Type*>(vparams), false);
                                                        func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, (char*)$2, module);
                                                    }
                                                    func_cur = func;
                                                    llvm::BasicBlock *entryBB = llvm::BasicBlock::Create(context, "entry", func_cur);
                                                    builder->SetInsertPoint(entryBB);
                                                    std::vector<std::pair<llvm::Value*, llvm::Value*>> pert;
                                                    for (int ti = 0; ti < func_params_count.top(); ti++){
                                                        pert.push_back(std::make_pair(func_params_val.top()[ti], func->getArg(ti)));
                                                    }
                                                    variables.push_back(pert);
} STATEMENTS TRETURN ';' TRBRACE {
                                                    builder->CreateRetVoid();
                                                    }



STATEMENTS: %empty
            | STATEMENTS ASSIGNMENT           {}
            | STATEMENTS ROUTINE_CALL ';'     {}
            | STATEMENTS IF_STATEMENT         {}
            | STATEMENTS WHILE                {}
            | STATEMENTS FOR                  {}
            | STATEMENTS LABEL                {}
            | STATEMENTS GOTO                 {}
            | STATEMENTS EXT_WINDOW_CLEAR ';' {}
            | STATEMENTS EXT_CHECK_EVENT ';'  {}
            | STATEMENTS EXT_FLUSH ';'        {}
            | STATEMENTS EXT_INIT_WINDOW ';'  {}
            | STATEMENTS EXT_PUT_PIXEL ';'    {}
            | STATEMENTS EXT_PRINT ';'        {}


ASSIGNMENT: VALUE TEQUAL EXPRESSION ';' { builder->CreateStore($3, $1);}

ROUTINE_CALL: TIDENTIFIER TLPAREN EXPRESSION TRPAREN {
                            llvm::Function *func = module->getFunction((char*)$1);
                            if (func == nullptr) {
                                llvm::FunctionType *funcType = 
                                                        llvm::FunctionType::get(builder->getInt32Ty(), false);
                                func = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, (char*)$1, module);
                            }
                            $$ = builder->CreateCall(func);

                        }

IF_STATEMENT: TIF EXPRESSION TLBRACE {
                            llvm::Value *cond = builder->CreateICmpNE($2, builder->getInt32(0));
                            auto&& condT = llvm::BasicBlock::Create(context, "", func_cur);
                            auto&& condF = llvm::BasicBlock::Create(context, "", func_cur);
                            gcondF = condF;
                            builder->CreateCondBr(cond, condT, condF);
                            builder->SetInsertPoint(condT);

                        }
STATEMENTS TRBRACE  {
                            builder->CreateBr(gcondF);
                            builder->SetInsertPoint(gcondF);
                        }



WHILE: TWHILE  {                    
                        auto&& condBB = llvm::BasicBlock::Create(context, "", func_cur);
                        builder->CreateBr(condBB);
                        builder->SetInsertPoint(condBB);
                        BB_while_cond.push(condBB);
} EXPRESSION TLBRACE   {
                        auto && cond = builder->CreateICmpNE($3, builder->getInt32(0));
                        auto&& falseBB = llvm::BasicBlock::Create(context, "", func_cur);
                        auto&& trueBB = llvm::BasicBlock::Create(context, "", func_cur);

                        builder->CreateCondBr(cond, trueBB, falseBB);
                        builder->SetInsertPoint(trueBB);

                        BB_while_false.push(falseBB);

} STATEMENTS TRBRACE   {
                        builder->CreateBr(BB_while_cond.top());
                        builder->SetInsertPoint(BB_while_false.top());
                        BB_while_cond.pop();
                        BB_while_false.pop();
}

FOR: TFOR VALUE TSTART SIMPLE TFINISH SIMPLE TLBRACE {                    
                                        builder->CreateStore($4, $2);
                                        auto&& condBB = llvm::BasicBlock::Create(context, "", func_cur);
                                        builder->CreateBr(condBB);
                                        builder->SetInsertPoint(condBB);
                                        BB_while_cond.push(condBB);
                                        $$ = builder->CreateLoad($2);
                                        auto && cond = builder->CreateICmpSLT($$, $6);
                                        auto&& falseBB = llvm::BasicBlock::Create(context, "", func_cur);
                                        auto&& trueBB = llvm::BasicBlock::Create(context, "", func_cur);
                                        builder->CreateCondBr(cond, trueBB, falseBB);
                                        builder->SetInsertPoint(trueBB);
                                        BB_while_false.push(falseBB);
                                        for_counter.push($2);
} STATEMENTS TRBRACE {
                                        $$ = builder ->CreateLoad(for_counter.top());
                                        $$ = builder->CreateAdd($$, llvm::ConstantInt::get(builder->getInt32Ty(), 1));
                                        builder->CreateStore($$, for_counter.top());
                                        builder->CreateBr(BB_while_cond.top());

                                        builder->SetInsertPoint(BB_while_false.top());
                                        BB_while_cond.pop();
                                        BB_while_false.pop();
                                        for_counter.pop();
}

EXPRESSION : TEXPRESSION
             | TEXPRESSION '&' '&' TEXPRESSION { $$ = builder->CreateAnd($1, $4); }
             | TEXPRESSION '|' '|' TEXPRESSION { $$ = builder->CreateOr($1, $4); }
             | %empty

TEXPRESSION: SIMPLE
            | TEXPRESSION TCNE SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpNE($1, $3), builder->getInt32Ty()); }
            | TEXPRESSION TCEQ SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpEQ($1, $3), builder->getInt32Ty()); }
            | TEXPRESSION TCLT SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSLT($1, $3), builder->getInt32Ty()); }
            | TEXPRESSION TCLE SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSLE($1, $3), builder->getInt32Ty()); }
            | TEXPRESSION TCGT SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSGT($1, $3), builder->getInt32Ty()); }
            | TEXPRESSION TCGE SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSGE($1, $3), builder->getInt32Ty()); }
            | ROUTINE_CALL
;
SIMPLE:     SUMMAND
            | SIMPLE '+' SUMMAND { $$ = builder->CreateAdd($1, $3); }
            | SIMPLE '-' SUMMAND { $$ = builder->CreateSub($1, $3); }
            

SUMMAND:    FACTOR
            | SUMMAND '*' FACTOR  { $$ = builder->CreateMul($1, $3); }
            | SUMMAND '/' FACTOR  { $$ = builder->CreateSDiv($1, $3); }
            | SUMMAND '%' FACTOR  { $$ = builder->CreateSRem($1, $3); }
;

FACTOR:     PRIMARY                      { $$ = $1; }
            | '-' PRIMARY                { $$ = builder->CreateNeg($2); }
            | TLPAREN EXPRESSION TRPAREN { $$ =$2; }
;

PRIMARY:    TINTEGER { $$ = builder->getInt32(atoi((char*)$1)); }
            | VALUE  { $$ = builder->CreateLoad($1); }
;

VALUE:      TIDENTIFIER {
                            if (value_map.find((char*)$1) != value_map.end()) {
                                $$ = builder->CreateConstGEP1_32(value_map[(char*)$1].val_ir, 0);
                            }
                        }
            | TIDENTIFIER '[' EXPRESSION ']' {
                            llvm::ArrayType *arrayType = llvm::ArrayType::get(builder->getInt32Ty(), array_map[(char*)$1].size);
                            std::vector<llvm::Value *> gepArgs;
                            gepArgs.push_back(builder->getInt32(0));
                            gepArgs.push_back($3);
                            $$ = builder->CreateGEP(arrayType, array_map[(char*)$1].val_ir, gepArgs);
                        }
            | TIDENTIFIER '[' EXPRESSION ']' '[' EXPRESSION ']' {
                            llvm::ArrayType *arrayType = llvm::ArrayType::get(llvm::ArrayType::get(builder->getInt32Ty(), array2_map[(char*)$1].sizej),array2_map[(char*)$1].sizei);
                            std::vector<llvm::Value *> gepArgs;
                            gepArgs.push_back(builder->getInt32(0));
                            gepArgs.push_back($3);
                            gepArgs.push_back($6);
                            $$ = builder->CreateGEP(arrayType, array2_map[(char*)$1].val_ir, gepArgs);
                        }

%%