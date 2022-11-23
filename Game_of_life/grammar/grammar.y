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

std::map<std::string, array_t> array_map;
std::stack<int> func_params_count;
std::stack<std::vector<llvm::Value *>> func_params_val;
std::map<std::string, llvm::BasicBlock *> BB_map;

int main(int argc, char **argv)
{
    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmPrinter();

    module = new llvm::Module("noname", context);
    builder = new llvm::IRBuilder<> (context);

    yyparse();

    llvm::outs() << "LLVM IR:\n";
    module->print(llvm::outs(), nullptr);

    // LLVM IR
    llvm::outs() << "RUNNING\n";
	llvm::ExecutionEngine *EE = llvm::EngineBuilder(std::unique_ptr<llvm::Module>(module)).create();

    for (auto& value : value_map) {
        EE->addGlobalMapping(value.second.val_ir, &value.second.val_real);
    }
    for (auto& array : array_map) {
        array.second.val_real = new int[array.second.size];
        for (int i = 0; i < array.second.size; i++) {
            array.second.val_real[i] = array.second.val_init;
        }
        EE->addGlobalMapping(array.second.val_ir, array.second.val_real);
    }

    EE->finalizeObject();
	std::vector<llvm::GenericValue> no_args;
    llvm::Function *func_main = module->getFunction("main");
    if (func_main == nullptr) {
	    llvm::outs() << "ERROR: main was not found\n";
        return -1;
    }
	EE->runFunction(func_main, no_args);
	llvm::outs() << "SUCCESS\n";

    for (auto& value : value_map) {
        llvm::outs() << value.first << " = " <<  value.second.val_real << "\n";
    }
    for (auto& array : array_map) {
        llvm::outs() << array.first << "[" << array.second.size << "] =";
        for (int i = 0; i < array.second.size; i++) {
            llvm::outs() << " " << array.second.val_real[i];
        }
        llvm::outs() << "\n";
        delete array.second.val_real;
    }
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


%%

Parse: Program {YYACCEPT;}

Program: ROUTINE_DECLARE {}
         | VARIABLE_DECLARE {} 
         | Program VARIABLE_DECLARE {}
         | Program ROUTINE_DECLARE {}


VARIABLE_DECLARE : TTYPE TIDENTIFIER TEQUAL TINTEGER ';' {
                                                    printf("TTYPE TIDENTIFIER TEQUAL TINTEGER ';'\n");
                                                    module->getOrInsertGlobal((char*)$2, builder->getInt32Ty());
                                                    value_t val;
                                                    val.val_ir = module->getNamedGlobal((char*)$2);
                                                    val.val_real = atoi((char*)$4);
                                                    value_map.insert({(char*)$2, val});
                                                }
                   | TTYPE TIDENTIFIER '[' TINTEGER ']' TEQUAL TINTEGER ';' {
                                                    printf("TTYPE TIDENTIFIER '[' TINTEGER ']'TEQUAL TINTEGER ';'\n");
                                                    int size = atoi((char*)$4);
                                                    llvm::ArrayType *array_type = llvm::ArrayType::get(builder->getInt32Ty(), size);
                                                    module->getOrInsertGlobal((char*)$2, array_type);
                                                    array_t arr;
                                                    arr.val_ir = module->getNamedGlobal((char*)$2);
                                                    arr.size = atoi((char*)$4);
                                                    arr.val_init = atoi((char*)$7);
                                                    array_map.insert({(char*)$2, arr});
                                                }

PARAMETERS : %empty {printf("NULL\n"); func_params_count.push(0);}
             | TTYPE TIDENTIFIER {printf("TTYPE TIDENTIFIER"); func_params_count.push(1); func_params_val.push({$2});}
             | PARAMETERS TCOMMA TTYPE TIDENTIFIER {printf("PARAMETERS TCOMMA TTYPE TIDENTIFIER"); int k = func_params_count.top(); func_params_count.pop(); func_params_count.push(k+1); func_params_val.top().push_back($4);}

ROUTINE_DECLARE : TTYPE TIDENTIFIER TLPAREN PARAMETERS TRPAREN TLBRACE {
                                                    printf("ROUTINE_DECLARE...\n");
                                                    llvm::Function *func = module->getFunction((char*)$2);
                                                    if (func == nullptr) {
                                                        int t_count = 0;
                                                        t_count = func_params_count.top();
                                                        std::vector <llvm::Type*> vparams = {};
                                                        for (int i = 0; i < t_count; i++)
                                                        {
                                                            vparams.push_back(builder->getInt32Ty());
                                                        }
                                                        printf("t_count is %d\n", t_count);
                                                        llvm::FunctionType *func_type;
                                                        if (strncmp((char*)$1, "int", 3)) 
                                                            func_type = llvm::FunctionType::get(builder->getInt32Ty(), llvm::ArrayRef<llvm::Type*>(vparams), false);
                                                        else 
                                                            func_type = llvm::FunctionType::get(builder->getVoidTy(), llvm::ArrayRef<llvm::Type*>(vparams), false);

                                                        func = llvm::Function::Create(func_type, llvm::Function::ExternalLinkage, (char*)$2, module);
                                                    }
                                                    func_cur = func;

                                                    // entry:
                                                    llvm::BasicBlock *entryBB = llvm::BasicBlock::Create(context, "entry", func_cur);
                                                    builder->SetInsertPoint(entryBB);
                                                    std::vector<std::pair<llvm::Value*, llvm::Value*>> pairs;
                                                    for (int i = 0; i < func_params_count.top(); i++){
                                                        pairs.push_back(std::make_pair(func_params_val.top()[i], func->getArg(i)));
                                                    }
                                                    printf("pairs size is %d\n", pairs.size());
                                                    if (pairs.size() > 0)
                                                        printf("pairs is %s\n", (char*)pairs[0].first);
                                                    variables.push_back(pairs);
} STATEMENTS TRETURN EXPRESSION ';' TRBRACE { 
                                                    printf("... STATEMENTS START\n");
                                                    builder->CreateRet($10);
                                                    printf("... STATEMENTS FINISH\n");
                                                    }



STATEMENTS: %empty
            | STATEMENTS ASSIGNMENT       {printf("STATEMENTS ASSIGNMENT\n");}
            | STATEMENTS ROUTINE_CALL ';' {printf("STATEMENTS ROUTINE_CALL\n");}
            | STATEMENTS STATEMENT_IF     {printf("STATEMENTS STATEMENT_IF\n");}
            | STATEMENTS STATEMENT_WHILE  {printf("STATEMENTS STATEMENT_WHILE\n");}
            | STATEMENTS STATEMENT_FOR    {printf("STATEMENTS STATEMENT_FOR\n");}
            | STATEMENTS LABEL            {printf("STATEMENTS LABEL\n");}


ASSIGNMENT: VALUE TEQUAL EXPRESSION ';' { printf("VALUE TEQUAL EXPRESSION ';'\n"); builder->CreateStore($3, $1); }

ROUTINE_CALL: TIDENTIFIER TLPAREN EXPRESSION TRPAREN {
                            printf("ROUTINE_CALL START\n");
                            llvm::Function *func = module->getFunction((char*)$1);
                            if (func == nullptr) {
                                llvm::FunctionType *func_type = 
                                                        llvm::FunctionType::get(builder->getInt32Ty(), false);
                                func = llvm::Function::Create(func_type, llvm::Function::ExternalLinkage, (char*)$1, module);
                            }
                            $$ = builder->CreateCall(func, $3);
                            printf("ROUTINE_CALL FINISH\n");

                        }

STATEMENT_IF: TIF EXPRESSION '|' TIDENTIFIER '|' TIDENTIFIER ';' {
                            if (BB_map.find((char*)$4) == BB_map.end()) {
                                BB_map.insert({(char*)$4, llvm::BasicBlock::Create(context, (char*)$4, func_cur)});
                            }
                            if (BB_map.find((char*)$6) == BB_map.end()) {
                                BB_map.insert({(char*)$6, llvm::BasicBlock::Create(context, (char*)$6, func_cur)});
                            }
                            llvm::Value *cond = builder->CreateICmpNE($2, builder->getInt32(0));
                            builder->CreateCondBr(cond, BB_map[(char*)$4], BB_map[(char*)$6]);
                        }   

LABEL: TIDENTIFIER ':'  {
                            if(BB_map.find((char*) $1) == BB_map.end()) {
                                BB_map.insert({(char*)$1, llvm::BasicBlock::Create(context, (char*)$1, func_cur)});
                            }
                            llvm::BasicBlock *BB = BB_map[(char*)$1];
                            builder->CreateBr(BB);
                            builder->SetInsertPoint(BB);
                        }

STATEMENT_WHILE: TWHILE  {                    
                                        printf("STATEMENT_WHILE START\n");
                                        auto&& BB_cond = llvm::BasicBlock::Create(context, "", func_cur);
                                        builder->CreateBr(BB_cond);
                                        builder->SetInsertPoint(BB_cond);
                                        BB_while_cond.push(BB_cond);
} EXPRESSION TLBRACE   {
                                        printf("EXPRESSION START\n");
                                        auto && cond = builder->CreateICmpNE($3, builder->getInt32(0));
                                        auto&& BB_false = llvm::BasicBlock::Create(context, "", func_cur);
                                        auto&& BB_true = llvm::BasicBlock::Create(context, "", func_cur);

                                        builder->CreateCondBr(cond, BB_true, BB_false);
                                        builder->SetInsertPoint(BB_true);

                                        BB_while_false.push(BB_false);
                                        printf("EXPRESSION FINISH\n");

} STATEMENTS TRBRACE   {
                                        printf("STATEMENTS START\n");
                                        builder->CreateBr(BB_while_cond.top());
                                        builder->SetInsertPoint(BB_while_false.top());
                                        BB_while_cond.pop();
                                        BB_while_false.pop();
                                        printf("STATEMENT_WHILE FINISH\n");
}


STATEMENT_FOR: TFOR VALUE TSTART OP_SIMPLE TFINISH OP_SIMPLE TLBRACE {                    
                                        printf("STATEMENT_FOR START\n");
                                        builder->CreateStore($4, $2);
                                        auto&& BB_cond = llvm::BasicBlock::Create(context, "", func_cur);
                                        builder->CreateBr(BB_cond);
                                        builder->SetInsertPoint(BB_cond);
                                        BB_while_cond.push(BB_cond);

                                        $$ = builder->CreateLoad($2);
                                        auto && cond = builder->CreateICmpSLT($$, $6);
                                        auto&& BB_false = llvm::BasicBlock::Create(context, "", func_cur);
                                        auto&& BB_true = llvm::BasicBlock::Create(context, "", func_cur);
                                        builder->CreateCondBr(cond, BB_true, BB_false);
                                        builder->SetInsertPoint(BB_true);
                                        BB_while_false.push(BB_false);
                                        for_counter.push($2);
} STATEMENTS TRBRACE {
                                        printf("STATEMENTS START\n");
                                        $$ = builder ->CreateLoad(for_counter.top());
                                        $$ = builder->CreateAdd($$, llvm::ConstantInt::get(builder->getInt32Ty(), 1));
                                        builder->CreateStore($$, for_counter.top());
                                        builder->CreateBr(BB_while_cond.top());
                                        builder->SetInsertPoint(BB_while_false.top());
                                        BB_while_cond.pop();
                                        BB_while_false.pop();
                                        for_counter.pop();
                                        printf("STATEMENT_FOR FINISH\n");
}


EXPRESSION: OP_SIMPLE
            | EXPRESSION TCNE OP_SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpNE($1, $3),  builder->getInt32Ty()); }
            | EXPRESSION TCEQ OP_SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpEQ($1, $3),  builder->getInt32Ty()); }
            | EXPRESSION TCLT OP_SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSLT($1, $3), builder->getInt32Ty()); }
            | EXPRESSION TCLE OP_SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSLE($1, $3), builder->getInt32Ty()); }
            | EXPRESSION TCGT OP_SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSGT($1, $3), builder->getInt32Ty()); }
            | EXPRESSION TCGE OP_SIMPLE { $$ = builder->CreateZExt(builder->CreateICmpSGE($1, $3), builder->getInt32Ty()); }
            | ROUTINE_CALL
            | %empty
;
OP_SIMPLE:  OP_BIN
            | OP_SIMPLE '+' OP_BIN { $$ = builder->CreateAdd($1, $3); }
            | OP_SIMPLE '-' OP_BIN { $$ = builder->CreateSub($1, $3); }

OP_BIN:     SIGN
            | OP_BIN '*' SIGN  { $$ = builder->CreateMul($1, $3); }
            | OP_BIN '/' SIGN  { $$ = builder->CreateSDiv($1, $3); }
            | OP_BIN '%' SIGN  { $$ = builder->CreateSRem($1, $3); }
;

SIGN:       PRIMARY { $$ = $1; }
            | '-' PRIMARY { $$ = builder->CreateNeg($2); }
            | TLPAREN EXPRESSION TRPAREN { $$ =$2; }
;

PRIMARY:    TINTEGER { $$ = builder->getInt32(atoi((char*)$1)); }
            | VALUE { $$ = builder->CreateLoad($1); }
;

VALUE:      TIDENTIFIER  {
                            if (value_map.find((char*)$1) != value_map.end()) {
                                $$ = builder->CreateConstGEP1_32(value_map[(char*)$1].val_ir, 0);
                            }
                            else {
                                printf("searching %s in local variables\n", (char*)$1);
                                for (auto ii:variables.back()) {
                                    printf("i1.first is %s\n", (char*)ii.first);

                                    if (strcmp((char*)$1, (char*)ii.first), 1) {printf("FOUND\n"); $$ = builder->CreateAlloca(builder->getInt32Ty()); builder->CreateStore(ii.second, $$); }}
                            }
                        }
            | TIDENTIFIER '[' EXPRESSION ']' {
                            llvm::ArrayType *array_type = llvm::ArrayType::get(builder->getInt32Ty(), array_map[(char*)$1].size);
                            std::vector<llvm::Value *> gepArgs;
                            gepArgs.push_back(builder->getInt32(0));
                            gepArgs.push_back($3);
                            $$ = builder->CreateGEP(array_type, array_map[(char*)$1].val_ir, gepArgs);
                        }

%%