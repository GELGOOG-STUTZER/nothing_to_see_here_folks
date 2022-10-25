#include <iostream>
#include <fstream>
#include <unordered_map>

#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include <llvm/IR/Verifier.h>
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

llvm::GlobalVariable* A = nullptr;
llvm::GlobalVariable* B = nullptr;
llvm::LLVMContext context;
llvm::IRBuilder<> builder (context);

void dump_codegen(llvm::Module* module) {
    std::string s;
    llvm::raw_string_ostream os(s);
    module->print(os, nullptr);
    os.flush();
    std::cout << s;
}

int main()
{
    // LLVMInitializeNativeTarget();
    // llvm::InitializeNativeTarget();
    // llvm::InitializeNativeTargetAsmPrinter();

    // ; ModuleID = 'main.cpp'
    // source_filename = "main.cpp"
    llvm::Module* module = new llvm::Module("main.cpp", context);

    // @a = dso_local global [500 x [500 x i32]] zeroinitializer, align 16
    // @b = dso_local global [500 x [500 x i32]] zeroinitializer, align 16
    llvm::Type* Type = llvm::ArrayType::get (
        llvm::ArrayType::get (builder.getInt32Ty () , 500) , 500);
    module->getOrInsertGlobal ("a" , Type);
    A = module->getNamedGlobal ("a");
    A->setDSOLocal(true);
    A->setAlignment (llvm::MaybeAlign (16));
    A->setInitializer (llvm::ConstantAggregateZero::get (Type));

    Type = llvm::ArrayType::get (
        llvm::ArrayType::get (builder.getInt32Ty () , 500) , 500);
    module->getOrInsertGlobal ("b" , Type);
    B = module->getNamedGlobal ("b");
    B->setDSOLocal(true);
    B->setAlignment (llvm::MaybeAlign (16));
    B->setInitializer (llvm::ConstantAggregateZero::get (Type));

    llvm::FunctionType *funcType = llvm::FunctionType::get(builder.getVoidTy(), 
        {
            builder.getInt32Ty(), 
            builder.getInt32Ty(), 
            builder.getInt32Ty()
        }, 
        false
    );

    llvm::Function* fun_put_pixel = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "put_pixel", module);
    fun_put_pixel->setDSOLocal(true);

    funcType = llvm::FunctionType::get(builder.getVoidTy(), 
        {
            builder.getInt32Ty(),
            builder.getInt32Ty()
        }, 
        false
    );
    llvm::Function* fun_init_window = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z11init_windowjj", module);
    fun_init_window->setDSOLocal(true);

    funcType = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::Function* fun_check_event = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z11check_eventv", module);
    fun_check_event->setDSOLocal(true);

    llvm::Function* fun_window_clear = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z12window_clearv", module);
    fun_window_clear->setDSOLocal(true);

    llvm::Function* fun_flush = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z5flushv", module);
    fun_flush->setDSOLocal(true);

    funcType = llvm::FunctionType::get(builder.getInt1Ty(), false);
    llvm::Function* fun_window_is_open = llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "_Z14window_is_openv", module);
    fun_window_is_open->setDSOLocal(true);
    fun_window_is_open->addAttribute(0, llvm::Attribute::ZExt);




    // ; Function Attrs: noinline optnone uwtable
    // define dso_local void @_Z6recalcv() #0 {
    funcType = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::Function* fun_recalc = llvm::Function::Create (funcType , llvm::Function::ExternalLinkage , "_Z6recalcv" , module);
    fun_recalc->setDSOLocal(true);

    // 0:
    std::unordered_map<int, llvm::BasicBlock*> bb;
    bb[0] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[8] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[11] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[12] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[15] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[27] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[32] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[35] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[40] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[44] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[48] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[51] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[54] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[57] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[60] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[61] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[70] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[73] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[74] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[77] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[78] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[81] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[90] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[93] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[96] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[103] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[112] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[115] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[122] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[129] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[130] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[133] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[134] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[137] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[138] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[141] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[142] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[145] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[159] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[162] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[163] = llvm::BasicBlock::Create(context, "", fun_recalc);
    bb[166] = llvm::BasicBlock::Create(context, "", fun_recalc);

    // %1 = alloca i32, align 4
    // %2 = alloca i32, align 4
    // %3 = alloca i32, align 4
    // %4 = alloca i32, align 4
    // %5 = alloca i32, align 4
    // %6 = alloca i32, align 4
    // %7 = alloca i32, align 4
    // store i32 0, i32* %2, align 4
    // br label %8
    builder.SetInsertPoint(bb[0]);
    llvm::AllocaInst *value1 = builder.CreateAlloca(builder.getInt32Ty());
    value1->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *value2 = builder.CreateAlloca(builder.getInt32Ty());
    value2->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *value3 = builder.CreateAlloca(builder.getInt32Ty());
    value3->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *value4 = builder.CreateAlloca(builder.getInt32Ty());
    value4->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *value5 = builder.CreateAlloca(builder.getInt32Ty());
    value5->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *value6 = builder.CreateAlloca(builder.getInt32Ty());
    value6->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *value7 = builder.CreateAlloca(builder.getInt32Ty());
    value7->setAlignment(llvm::MaybeAlign(4));
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty (), 0), value2, llvm::MaybeAlign (4));
    builder.CreateBr(bb[8]);

    // 8:                                                ; preds = %134, %0
    // %9 = load i32, i32* %2, align 4
    // %10 = icmp slt i32 %9, 500
    // br i1 %10, label %11, label %137
    builder.SetInsertPoint(bb[8]);
    llvm::Value *value9 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value10 = builder.CreateICmpSLT(value9, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(value10, bb[11], bb[137]);

    // 11:                                               ; preds = %8
    // store i32 0, i32* %3, align 4
    // br label %12
    builder.SetInsertPoint(bb[11]);
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty (), 0), value3, llvm::MaybeAlign (4));
    builder.CreateBr(bb[12]);

    // 12:                                               ; preds = %130, %11
    // %13 = load i32, i32* %3, align 4
    // %14 = icmp slt i32 %13, 500
    // br i1 %14, label %15, label %133
    builder.SetInsertPoint(bb[12]);
    llvm::Value *value13 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value14 = builder.CreateICmpSLT(value13, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(value14, bb[15], bb[133]);

    // 15:                                               ; preds = %12
    // %16 = load i32, i32* %2, align 4
    // %17 = load i32, i32* %3, align 4
    // %18 = load i32, i32* %2, align 4
    // %19 = sext i32 %18 to i64
    // %20 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %19
    // %21 = load i32, i32* %3, align 4
    // %22 = sext i32 %21 to i64
    // %23 = getelementptr inbounds [500 x i32], [500 x i32]* %20, i64 0, i64 %22
    // %24 = load i32, i32* %23, align 4
    // call void @put_pixel(i32 %16, i32 %17, i32 %24)
    // store i32 0, i32* %1, align 4
    // %25 = load i32, i32* %2, align 4
    // %26 = sub nsw i32 %25, 1
    // store i32 %26, i32* %4, align 4
    // br label %27
    builder.SetInsertPoint(bb[15]);
    llvm::Value *value16 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value17 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value18 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value19 = builder.CreateSExt (value18, builder.getInt64Ty ());
    llvm::Value *value20 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value19
        }
    );
    llvm::Value *value21 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value22 = builder.CreateSExt (value21, builder.getInt64Ty ());
    llvm::Value *value23 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value20,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value22
        }
    );
    llvm::Value *value24 = builder.CreateAlignedLoad(builder.getInt32Ty(), value23, llvm::MaybeAlign (4));
    auto&& func_put_pixel = module->getFunction("put_pixel");
    builder.CreateCall(
        func_put_pixel->getFunctionType(),
        func_put_pixel,
        {
            value16,
            value17,
            value24,
        });
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 0), value1, llvm::MaybeAlign (4));
    llvm::Value *value25 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value26 = builder.CreateNSWSub(value25, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value26, value4, llvm::MaybeAlign (4));
    builder.CreateBr(bb[27]);

    // 27:                                               ; preds = %78, %15
    // %28 = load i32, i32* %4, align 4
    // %29 = load i32, i32* %2, align 4
    // %30 = add nsw i32 %29, 1
    // %31 = icmp sle i32 %28, %30
    // br i1 %31, label %32, label %81
    builder.SetInsertPoint(bb[27]);
    llvm::Value *value28 = builder.CreateAlignedLoad(builder.getInt32Ty(), value4, llvm::MaybeAlign (4));
    llvm::Value *value29 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value30 = builder.CreateNSWAdd(value29, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    llvm::Value *value31 = builder.CreateICmpSLE(value28, value30);
    builder.CreateCondBr(value31, bb[32], bb[81]);

    // 32:                                               ; preds = %27
    // %33 = load i32, i32* %3, align 4
    // %34 = sub nsw i32 %33, 1
    // store i32 %34, i32* %5, align 4
    // br label %35
    builder.SetInsertPoint(bb[32]);
    llvm::Value *value33 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value34 = builder.CreateNSWSub(value33, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value34, value5, llvm::MaybeAlign (4));
    builder.CreateBr(bb[35]);

    // 35:                                               ; preds = %74, %32
    // %36 = load i32, i32* %5, align 4
    // %37 = load i32, i32* %3, align 4
    // %38 = add nsw i32 %37, 1
    // %39 = icmp sle i32 %36, %38
    // br i1 %39, label %40, label %77
    builder.SetInsertPoint(bb[35]);
    llvm::Value *value36 = builder.CreateAlignedLoad(builder.getInt32Ty(), value5, llvm::MaybeAlign (4));
    llvm::Value *value37 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value38 = builder.CreateNSWAdd(value37, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    llvm::Value *value39 = builder.CreateICmpSLE(value36, value38);
    builder.CreateCondBr(value39, bb[40], bb[77]);

    // 40:                                               ; preds = %35
    // %41 = load i32, i32* %4, align 4
    // %42 = load i32, i32* %2, align 4
    // %43 = icmp eq i32 %41, %42
    // br i1 %43, label %44, label %48
    builder.SetInsertPoint(bb[40]);
    llvm::Value *value41 = builder.CreateAlignedLoad(builder.getInt32Ty(), value4, llvm::MaybeAlign (4));
    llvm::Value *value42 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value43 = builder.CreateICmpEQ(value41, value42);
    builder.CreateCondBr(value43, bb[44], bb[48]);

    // 44:                                               ; preds = %40
    // %45 = load i32, i32* %5, align 4
    // %46 = load i32, i32* %3, align 4
    // %47 = icmp eq i32 %45, %46
    // br i1 %47, label %60, label %48
    builder.SetInsertPoint(bb[44]);
    llvm::Value *value45 = builder.CreateAlignedLoad(builder.getInt32Ty(), value5, llvm::MaybeAlign (4));
    llvm::Value *value46 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value47 = builder.CreateICmpEQ(value45, value46);
    builder.CreateCondBr(value47, bb[60], bb[48]);

    // 48:                                               ; preds = %44, %40
    // %49 = load i32, i32* %4, align 4
    // %50 = icmp slt i32 %49, 0
    // br i1 %50, label %60, label %51
    builder.SetInsertPoint(bb[48]);
    llvm::Value *value49 = builder.CreateAlignedLoad(builder.getInt32Ty(), value4, llvm::MaybeAlign (4));
    llvm::Value *value50 = builder.CreateICmpSLT(value49, llvm::ConstantInt::get(builder.getInt32Ty(), 0));
    builder.CreateCondBr(value50, bb[60], bb[51]);

    // 51:                                               ; preds = %48
    // %52 = load i32, i32* %5, align 4
    // %53 = icmp slt i32 %52, 0
    // br i1 %53, label %60, label %54
    builder.SetInsertPoint(bb[51]);
    llvm::Value *value52 = builder.CreateAlignedLoad(builder.getInt32Ty(), value5, llvm::MaybeAlign (4));
    llvm::Value *value53 = builder.CreateICmpSLT(value52, llvm::ConstantInt::get(builder.getInt32Ty(), 0));
    builder.CreateCondBr(value53, bb[60], bb[54]);

    // 54:                                               ; preds = %51
    // %55 = load i32, i32* %4, align 4
    // %56 = icmp sge i32 %55, 500
    // br i1 %56, label %60, label %57
    builder.SetInsertPoint(bb[54]);
    llvm::Value *value55 = builder.CreateAlignedLoad(builder.getInt32Ty(), value4, llvm::MaybeAlign (4));
    llvm::Value *value56 = builder.CreateICmpSGE(value55, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(value56, bb[60], bb[57]);

    // 57:                                               ; preds = %54
    // %58 = load i32, i32* %5, align 4
    // %59 = icmp sge i32 %58, 500
    // br i1 %59, label %60, label %61
    builder.SetInsertPoint(bb[57]);
    llvm::Value *value58 = builder.CreateAlignedLoad(builder.getInt32Ty(), value5, llvm::MaybeAlign (4));
    llvm::Value *value59 = builder.CreateICmpSGE(value58, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(value59, bb[60], bb[61]);

    // 60:                                               ; preds = %57, %54, %51, %48, %44
    // br label %74
    builder.SetInsertPoint(bb[60]);
    builder.CreateBr(bb[74]);

    // 61:                                               ; preds = %57
    // %62 = load i32, i32* %4, align 4
    // %63 = sext i32 %62 to i64
    // %64 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %63
    // %65 = load i32, i32* %5, align 4
    // %66 = sext i32 %65 to i64
    // %67 = getelementptr inbounds [500 x i32], [500 x i32]* %64, i64 0, i64 %66
    // %68 = load i32, i32* %67, align 4
    // %69 = icmp eq i32 %68, 1
    // br i1 %69, label %70, label %73
    builder.SetInsertPoint(bb[61]);
    llvm::Value *value62 = builder.CreateAlignedLoad(builder.getInt32Ty(), value4, llvm::MaybeAlign (4));
    llvm::Value *value63 = builder.CreateSExt (value62, builder.getInt64Ty());
    llvm::Value *value64 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value63
        }
    );
    llvm::Value *value65 = builder.CreateAlignedLoad(builder.getInt32Ty(), value5, llvm::MaybeAlign (4));
    llvm::Value *value66 = builder.CreateSExt (value65, builder.getInt64Ty ());
    llvm::Value *value67 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value64,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value66
        }
    );
    llvm::Value *value68 = builder.CreateAlignedLoad(builder.getInt32Ty(), value67, llvm::MaybeAlign (4));
    llvm::Value *value69 = builder.CreateICmpEQ(value68, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateCondBr(value69, bb[70], bb[73]);

    // 70:                                               ; preds = %61
    // %71 = load i32, i32* %1, align 4
    // %72 = add nsw i32 %71, 1
    // store i32 %72, i32* %1, align 4
    // br label %73
    builder.SetInsertPoint(bb[70]);
    llvm::Value *value71 = builder.CreateAlignedLoad(builder.getInt32Ty(), value1, llvm::MaybeAlign (4));
    llvm::Value *value72 = builder.CreateNSWAdd(value71, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value72, value1, llvm::MaybeAlign (4));
    builder.CreateBr(bb[73]);

    // 73:                                               ; preds = %70, %61
    // br label %74
    builder.SetInsertPoint(bb[73]);
    builder.CreateBr(bb[74]);

    // 74:                                               ; preds = %73, %60
    // %75 = load i32, i32* %5, align 4
    // %76 = add nsw i32 %75, 1
    // store i32 %76, i32* %5, align 4
    // br label %35
    builder.SetInsertPoint(bb[74]);
    llvm::Value *value75 = builder.CreateAlignedLoad(builder.getInt32Ty(), value5, llvm::MaybeAlign (4));
    llvm::Value *value76 = builder.CreateNSWAdd(value75, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value76, value5, llvm::MaybeAlign (4));
    builder.CreateBr(bb[35]);

    // 77:                                               ; preds = %35
    // br label %78
    builder.SetInsertPoint(bb[77]);
    builder.CreateBr(bb[78]);

    // 78:                                               ; preds = %77
    // %79 = load i32, i32* %4, align 4
    // %80 = add nsw i32 %79, 1
    // store i32 %80, i32* %4, align 4
    // br label %27
    builder.SetInsertPoint(bb[78]);
    llvm::Value *value79 = builder.CreateAlignedLoad(builder.getInt32Ty(), value4, llvm::MaybeAlign (4));
    llvm::Value *value80 = builder.CreateNSWAdd(value79, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value80, value4, llvm::MaybeAlign (4));
    builder.CreateBr(bb[27]);

    // 81:                                               ; preds = %27
    // %82 = load i32, i32* %2, align 4
    // %83 = sext i32 %82 to i64
    // %84 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %83
    // %85 = load i32, i32* %3, align 4
    // %86 = sext i32 %85 to i64
    // %87 = getelementptr inbounds [500 x i32], [500 x i32]* %84, i64 0, i64 %86
    // %88 = load i32, i32* %87, align 4
    // %89 = icmp eq i32 %88, 1
    // br i1 %89, label %90, label %103
    builder.SetInsertPoint(bb[81]);
    llvm::Value *value82 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value83 = builder.CreateSExt (value82, builder.getInt64Ty());
    llvm::Value *value84 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value83
        }
    );
    llvm::Value *value85 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value86 = builder.CreateSExt (value85, builder.getInt64Ty ());
    llvm::Value *value87 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value84,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value86
        }
    );
    llvm::Value *value88 = builder.CreateAlignedLoad(builder.getInt32Ty(), value87, llvm::MaybeAlign (4));
    llvm::Value *value89 = builder.CreateICmpEQ(value88, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateCondBr(value89, bb[90], bb[103]);

    // 90:                                               ; preds = %81
    // %91 = load i32, i32* %1, align 4
    // %92 = icmp eq i32 %91, 2
    // br i1 %92, label %96, label %93
    builder.SetInsertPoint(bb[90]);
    llvm::Value *value91 = builder.CreateAlignedLoad(builder.getInt32Ty(), value1, llvm::MaybeAlign (4));
    llvm::Value *value92 = builder.CreateICmpEQ(value91, llvm::ConstantInt::get(builder.getInt32Ty(), 2));
    builder.CreateCondBr(value92, bb[96], bb[93]);

    // 93:                                               ; preds = %90
    // %94 = load i32, i32* %1, align 4
    // %95 = icmp eq i32 %94, 3
    // br i1 %95, label %96, label %103
    builder.SetInsertPoint(bb[93]);
    llvm::Value *value94 = builder.CreateAlignedLoad(builder.getInt32Ty(), value1, llvm::MaybeAlign (4));
    llvm::Value *value95 = builder.CreateICmpEQ(value94, llvm::ConstantInt::get(builder.getInt32Ty(), 3));
    builder.CreateCondBr(value95, bb[96], bb[103]);

    // 96:                                               ; preds = %93, %90
    // %97 = load i32, i32* %2, align 4
    // %98 = sext i32 %97 to i64
    // %99 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %98
    // %100 = load i32, i32* %3, align 4
    // %101 = sext i32 %100 to i64
    // %102 = getelementptr inbounds [500 x i32], [500 x i32]* %99, i64 0, i64 %101
    // store i32 1, i32* %102, align 4
    // br label %130
    builder.SetInsertPoint(bb[96]);
    llvm::Value *value97 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value98 = builder.CreateSExt (value97, builder.getInt64Ty());
    llvm::Value *value99 = builder.CreateInBoundsGEP(B->getValueType(), B,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value98
        }
    );
    llvm::Value *value100 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value101 = builder.CreateSExt (value100, builder.getInt64Ty ());
    llvm::Value *value102 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value99,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value101
        }
    );
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 1), value102, llvm::MaybeAlign (4));
    builder.CreateBr(bb[130]);

    // 103:                                              ; preds = %93, %81
    // %104 = load i32, i32* %2, align 4
    // %105 = sext i32 %104 to i64
    // %106 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %105
    // %107 = load i32, i32* %3, align 4
    // %108 = sext i32 %107 to i64
    // %109 = getelementptr inbounds [500 x i32], [500 x i32]* %106, i64 0, i64 %108
    // %110 = load i32, i32* %109, align 4
    // %111 = icmp eq i32 %110, 0
    // br i1 %111, label %112, label %122
    builder.SetInsertPoint(bb[103]);
    llvm::Value *value104 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value105 = builder.CreateSExt (value104, builder.getInt64Ty());
    llvm::Value *value106 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value105
        }
    );
    llvm::Value *value107 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value108 = builder.CreateSExt (value107, builder.getInt64Ty ());
    llvm::Value *value109 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value106,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value108
        }
    );
    llvm::Value *value110 = builder.CreateAlignedLoad(builder.getInt32Ty(), value109, llvm::MaybeAlign (4));
    llvm::Value *value111 = builder.CreateICmpEQ(value110, llvm::ConstantInt::get(builder.getInt32Ty(), 0));
    builder.CreateCondBr(value111, bb[112], bb[122]);

    // 112:                                              ; preds = %103
    // %113 = load i32, i32* %1, align 4
    // %114 = icmp eq i32 %113, 3
    // br i1 %114, label %115, label %122
    builder.SetInsertPoint(bb[112]);
    llvm::Value *value113 = builder.CreateAlignedLoad(builder.getInt32Ty(), value1, llvm::MaybeAlign (4));
    llvm::Value *value114 = builder.CreateICmpEQ(value113, llvm::ConstantInt::get(builder.getInt32Ty(), 3));
    builder.CreateCondBr(value114, bb[115], bb[122]);

    // 115:                                              ; preds = %112
    // %116 = load i32, i32* %2, align 4
    // %117 = sext i32 %116 to i64
    // %118 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %117
    // %119 = load i32, i32* %3, align 4
    // %120 = sext i32 %119 to i64
    // %121 = getelementptr inbounds [500 x i32], [500 x i32]* %118, i64 0, i64 %120
    // store i32 1, i32* %121, align 4
    // br label %130
    builder.SetInsertPoint(bb[115]);
    llvm::Value *value116 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value117 = builder.CreateSExt (value116, builder.getInt64Ty());
    llvm::Value *value118 = builder.CreateInBoundsGEP(B->getValueType(), B,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value117
        }
    );
    llvm::Value *value119 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value120 = builder.CreateSExt (value119, builder.getInt64Ty ());
    llvm::Value *value121 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value118,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value120
        }
    );
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 1), value121, llvm::MaybeAlign (4));
    builder.CreateBr(bb[130]);

    // 122:                                              ; preds = %112, %103
    // %123 = load i32, i32* %2, align 4
    // %124 = sext i32 %123 to i64
    // %125 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %124
    // %126 = load i32, i32* %3, align 4
    // %127 = sext i32 %126 to i64
    // %128 = getelementptr inbounds [500 x i32], [500 x i32]* %125, i64 0, i64 %127
    // store i32 0, i32* %128, align 4
    // br label %129
    builder.SetInsertPoint(bb[122]);
    llvm::Value *value123 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value124 = builder.CreateSExt (value123, builder.getInt64Ty());
    llvm::Value *value125 = builder.CreateInBoundsGEP(B->getValueType(), B,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value124
        }
    );
    llvm::Value *value126 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value127 = builder.CreateSExt (value126, builder.getInt64Ty ());
    llvm::Value *value128 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value125,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value127
        }
    );
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 0), value128, llvm::MaybeAlign (4));
    builder.CreateBr(bb[129]);

    // 129:                                              ; preds = %122
    // br label %130
    builder.SetInsertPoint(bb[129]);
    builder.CreateBr(bb[130]);

    // 130:                                              ; preds = %129, %115, %96
    // %131 = load i32, i32* %3, align 4
    // %132 = add nsw i32 %131, 1
    // store i32 %132, i32* %3, align 4
    // br label %12
    builder.SetInsertPoint(bb[130]);
    llvm::Value *value131 = builder.CreateAlignedLoad(builder.getInt32Ty(), value3, llvm::MaybeAlign (4));
    llvm::Value *value132 = builder.CreateNSWAdd(value131, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value132, value3, llvm::MaybeAlign (4));
    builder.CreateBr(bb[12]);

    // 133:                                              ; preds = %12
    // br label %134
    builder.SetInsertPoint(bb[133]);
    builder.CreateBr(bb[134]);

    // 134:                                              ; preds = %133
    // %135 = load i32, i32* %2, align 4
    // %136 = add nsw i32 %135, 1
    // store i32 %136, i32* %2, align 4
    // br label %8
    builder.SetInsertPoint(bb[134]);
    llvm::Value *value135 = builder.CreateAlignedLoad(builder.getInt32Ty(), value2, llvm::MaybeAlign (4));
    llvm::Value *value136 = builder.CreateNSWAdd(value135, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value136, value2, llvm::MaybeAlign (4));
    builder.CreateBr(bb[8]);

    // 137:                                              ; preds = %8
    // store i32 0, i32* %6, align 4
    // br label %138
    builder.SetInsertPoint(bb[137]);
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 0), value6, llvm::MaybeAlign (4));
    builder.CreateBr(bb[138]);

    // 138:                                              ; preds = %163, %137
    // %139 = load i32, i32* %6, align 4
    // %140 = icmp slt i32 %139, 500
    // br i1 %140, label %141, label %166
    builder.SetInsertPoint(bb[138]);
    llvm::Value *value139 = builder.CreateAlignedLoad(builder.getInt32Ty(), value6, llvm::MaybeAlign (4));
    llvm::Value *value140 = builder.CreateICmpSLT(value139, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(value140, bb[141], bb[166]);

    // 141:                                              ; preds = %138
    // store i32 0, i32* %7, align 4
    // br label %142
    builder.SetInsertPoint(bb[141]);
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 0), value7, llvm::MaybeAlign (4));
    builder.CreateBr(bb[142]);

    // 142:                                              ; preds = %159, %141
    // %143 = load i32, i32* %7, align 4
    // %144 = icmp slt i32 %143, 500
    // br i1 %144, label %145, label %162
    builder.SetInsertPoint(bb[142]);
    llvm::Value *value143 = builder.CreateAlignedLoad(builder.getInt32Ty(), value7, llvm::MaybeAlign (4));
    llvm::Value *value144 = builder.CreateICmpSLT(value143, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(value144, bb[145], bb[162]);

    // 145:                                              ; preds = %142
    // %146 = load i32, i32* %6, align 4
    // %147 = sext i32 %146 to i64
    // %148 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %147
    // %149 = load i32, i32* %7, align 4
    // %150 = sext i32 %149 to i64
    // %151 = getelementptr inbounds [500 x i32], [500 x i32]* %148, i64 0, i64 %150
    // %152 = load i32, i32* %151, align 4
    // %153 = load i32, i32* %6, align 4
    // %154 = sext i32 %153 to i64
    // %155 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %154
    // %156 = load i32, i32* %7, align 4
    // %157 = sext i32 %156 to i64
    // %158 = getelementptr inbounds [500 x i32], [500 x i32]* %155, i64 0, i64 %157
    // store i32 %152, i32* %158, align 4
    // br label %159
    builder.SetInsertPoint(bb[145]);
    llvm::Value *value146 = builder.CreateAlignedLoad(builder.getInt32Ty(), value6, llvm::MaybeAlign (4));
    llvm::Value *value147 = builder.CreateSExt (value146, builder.getInt64Ty());
    llvm::Value *value148 = builder.CreateInBoundsGEP(B->getValueType(), B,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value147
        }
    );
    llvm::Value *value149 = builder.CreateAlignedLoad(builder.getInt32Ty(), value7, llvm::MaybeAlign (4));
    llvm::Value *value150 = builder.CreateSExt (value149, builder.getInt64Ty ());
    llvm::Value *value151 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value148,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value150
        }
    );
    llvm::Value *value152 = builder.CreateAlignedLoad(builder.getInt32Ty(), value151, llvm::MaybeAlign (4));
    llvm::Value *value153 = builder.CreateAlignedLoad(builder.getInt32Ty(), value6, llvm::MaybeAlign (4));
    llvm::Value *value154 = builder.CreateSExt (value153, builder.getInt64Ty ());
    llvm::Value *value155 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value154
        }
    );
    llvm::Value *value156 = builder.CreateAlignedLoad(builder.getInt32Ty(), value7, llvm::MaybeAlign (4));
    llvm::Value *value157 = builder.CreateSExt (value156, builder.getInt64Ty ());
    llvm::Value *value158 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), value155,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            value157
        }
    );
    builder.CreateAlignedStore(value152, value158, llvm::MaybeAlign (4));
    builder.CreateBr(bb[159]);

    // 159:                                              ; preds = %145
    // %160 = load i32, i32* %7, align 4
    // %161 = add nsw i32 %160, 1
    // store i32 %161, i32* %7, align 4
    // br label %142
    builder.SetInsertPoint(bb[159]);
    llvm::Value *value160 = builder.CreateAlignedLoad(builder.getInt32Ty(), value7, llvm::MaybeAlign (4));
    llvm::Value *value161 = builder.CreateNSWAdd(value160, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value161, value7, llvm::MaybeAlign (4));
    builder.CreateBr(bb[142]);

    // 162:                                              ; preds = %142
    // br label %163
    builder.SetInsertPoint(bb[162]);
    builder.CreateBr(bb[163]);

    // 163:                                              ; preds = %162
    // %164 = load i32, i32* %6, align 4
    // %165 = add nsw i32 %164, 1
    // store i32 %165, i32* %6, align 4
    // br label %138
    builder.SetInsertPoint(bb[163]);
    llvm::Value *value164 = builder.CreateAlignedLoad(builder.getInt32Ty(), value6, llvm::MaybeAlign (4));
    llvm::Value *value165 = builder.CreateNSWAdd(value164, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(value165, value6, llvm::MaybeAlign (4));
    builder.CreateBr(bb[138]);

    // 166:                                              ; preds = %138
    // ret void
    builder.SetInsertPoint(bb[166]);
    builder.CreateRetVoid();

    funcType = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::Function* fun_init_pixels = llvm::Function::Create (funcType , llvm::Function::ExternalLinkage , "_Z11init_pixelsv" , module);
    fun_init_pixels->setDSOLocal(true);

    // 0:
    llvm::BasicBlock *bb_0 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_3 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_6 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_7 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_10 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_16 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_23 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_30 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_31 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_34 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_35 = llvm::BasicBlock::Create(context, "", fun_init_pixels);
    llvm::BasicBlock *bb_38 = llvm::BasicBlock::Create(context, "", fun_init_pixels);

    // %1 = alloca i32, align 4
    // %2 = alloca i32, align 4
    // store i32 0, i32* %1, align 4
    // br label %3
    builder.SetInsertPoint(bb_0);
    llvm::AllocaInst *val1 = builder.CreateAlloca(builder.getInt32Ty());
    val1->setAlignment(llvm::MaybeAlign(4));
    llvm::AllocaInst *val2 = builder.CreateAlloca(builder.getInt32Ty());
    val2->setAlignment(llvm::MaybeAlign(4));
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty (), 0), val1, llvm::MaybeAlign (4));
    builder.CreateBr(bb_3);

    // 3:                                                ; preds = %35, %0
    // %4 = load i32, i32* %1, align 4
    // %5 = icmp slt i32 %4, 500
    // br i1 %5, label %6, label %38
    builder.SetInsertPoint(bb_3);
    llvm::Value *val4 = builder.CreateAlignedLoad(builder.getInt32Ty(), val1, llvm::MaybeAlign (4));
    llvm::Value *val5 = builder.CreateICmpSLT(val4, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(val5, bb_6, bb_38);

    // 6:                                                ; preds = %3
    // store i32 0, i32* %2, align 4
    // br label %7
    builder.SetInsertPoint(bb_6);
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty (), 0), val2, llvm::MaybeAlign (4));
    builder.CreateBr(bb_7);

    // 7:                                                ; preds = %31, %6
    // %8 = load i32, i32* %2, align 4
    // %9 = icmp slt i32 %8, 500
    // br i1 %9, label %10, label %34
    builder.SetInsertPoint(bb_7);
    llvm::Value *val8 = builder.CreateAlignedLoad(builder.getInt32Ty(), val2, llvm::MaybeAlign (4));
    llvm::Value *val9 = builder.CreateICmpSLT(val8, llvm::ConstantInt::get(builder.getInt32Ty(), 500));
    builder.CreateCondBr(val9, bb_10, bb_34);

    // 10:                                               ; preds = %7
    // %11 = load i32, i32* %1, align 4
    // %12 = load i32, i32* %2, align 4
    // %13 = add nsw i32 %11, %12
    // %14 = srem i32 %13, 3
    // %15 = icmp eq i32 %14, 0
    // br i1 %15, label %16, label %23
    builder.SetInsertPoint(bb_10);
    llvm::Value *val11 = builder.CreateAlignedLoad(builder.getInt32Ty(), val1, llvm::MaybeAlign (4));
    llvm::Value *val12 = builder.CreateAlignedLoad(builder.getInt32Ty(), val2, llvm::MaybeAlign (4));
    llvm::Value *val13 = builder.CreateNSWAdd(val11, val12);
    llvm::Value *val14 = builder.CreateSRem(val13, llvm::ConstantInt::get(builder.getInt32Ty(), 3));
    llvm::Value *val15 = builder.CreateICmpEQ(val14, llvm::ConstantInt::get(builder.getInt32Ty(), 0));
    builder.CreateCondBr(val15, bb_16, bb_23);

    // 16:                                               ; preds = %10
    // %17 = load i32, i32* %1, align 4
    // %18 = sext i32 %17 to i64
    // %19 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %18
    // %20 = load i32, i32* %2, align 4
    // %21 = sext i32 %20 to i64
    // %22 = getelementptr inbounds [500 x i32], [500 x i32]* %19, i64 0, i64 %21
    // store i32 1, i32* %22, align 4
    // br label %30
    builder.SetInsertPoint(bb_16);
    llvm::Value *val17 = builder.CreateAlignedLoad(builder.getInt32Ty(), val1, llvm::MaybeAlign (4));
    llvm::Value *val18 = builder.CreateSExt (val17, builder.getInt64Ty ());
    llvm::Value *val19 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            val18
        }
    );
    llvm::Value *val20 = builder.CreateAlignedLoad(builder.getInt32Ty(), val2, llvm::MaybeAlign (4));
    llvm::Value *val21 = builder.CreateSExt (val20, builder.getInt64Ty ());
    llvm::Value *val22 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), val19,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            val21
        }
    );
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 1), val22, llvm::MaybeAlign (4));
    builder.CreateBr(bb_30);

    // 23:                                               ; preds = %10
    // %24 = load i32, i32* %1, align 4
    // %25 = sext i32 %24 to i64
    // %26 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %25
    // %27 = load i32, i32* %2, align 4
    // %28 = sext i32 %27 to i64
    // %29 = getelementptr inbounds [500 x i32], [500 x i32]* %26, i64 0, i64 %28
    // store i32 0, i32* %29, align 4
    // br label %30
    builder.SetInsertPoint(bb_23);
    llvm::Value *val24 = builder.CreateAlignedLoad(builder.getInt32Ty(), val1, llvm::MaybeAlign (4));
    llvm::Value *val25 = builder.CreateSExt (val24, builder.getInt64Ty ());
    llvm::Value *val26 = builder.CreateInBoundsGEP(A->getValueType(), A,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            val25
        }
    );
    llvm::Value *val27 = builder.CreateAlignedLoad(builder.getInt32Ty(), val2, llvm::MaybeAlign (4));
    llvm::Value *val28 = builder.CreateSExt (val27, builder.getInt64Ty ());
    llvm::Value *val29 = builder.CreateInBoundsGEP(llvm::ArrayType::get(builder.getInt32Ty(), 500), val26,
        {        
            llvm::ConstantInt::get(builder.getInt64Ty(), 0),
            val28
        }
    );
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 0), val29, llvm::MaybeAlign (4));
    builder.CreateBr(bb_30);

    // 30:                                               ; preds = %23, %16
    // br label %31
    builder.SetInsertPoint(bb_30);
    builder.CreateBr(bb_31);

    // 31:                                               ; preds = %30
    // %32 = load i32, i32* %2, align 4
    // %33 = add nsw i32 %32, 1
    // store i32 %33, i32* %2, align 4
    // br label %7
    builder.SetInsertPoint(bb_31);
    llvm::Value *val32 = builder.CreateAlignedLoad(builder.getInt32Ty(), val2, llvm::MaybeAlign (4));
    llvm::Value *val33 = builder.CreateNSWAdd(val32, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(val33, val2, llvm::MaybeAlign (4));
    builder.CreateBr(bb_7);

    // 34:                                               ; preds = %7
    // br label %35
    builder.SetInsertPoint(bb_34);
    builder.CreateBr(bb_35);

    // 35:                                               ; preds = %34
    // %36 = load i32, i32* %1, align 4
    // %37 = add nsw i32 %36, 1
    // store i32 %37, i32* %1, align 4
    // br label %3
    builder.SetInsertPoint(bb_35);
    llvm::Value *val36 = builder.CreateAlignedLoad(builder.getInt32Ty(), val1, llvm::MaybeAlign (4));
    llvm::Value *val37 = builder.CreateNSWAdd(val36, llvm::ConstantInt::get(builder.getInt32Ty(), 1));
    builder.CreateAlignedStore(val37, val1, llvm::MaybeAlign (4));
    builder.CreateBr(bb_3);

    // 38:                                               ; preds = %3
    // ret void
    builder.SetInsertPoint(bb_38);
    builder.CreateRetVoid();

    funcType = llvm::FunctionType::get(
        builder.getInt32Ty(),
        false
    );
    llvm::Function* fun_main = llvm::Function::Create (funcType , llvm::Function::ExternalLinkage , "main" , module);
    fun_main->setDSOLocal(true);

    llvm::BasicBlock *bblock0 = llvm::BasicBlock::Create(context, "", fun_main);
    llvm::BasicBlock *bblock2 = llvm::BasicBlock::Create(context, "", fun_main);
    llvm::BasicBlock *bblock4 = llvm::BasicBlock::Create(context, "", fun_main);
    llvm::BasicBlock *bblock5 = llvm::BasicBlock::Create(context, "", fun_main);

    // 0:
    // %1 = alloca i32, align 4
    // store i32 0, i32* %1, align 4
    // call void @_Z11init_windowjj(i32 500, i32 500)
    // call void @_Z11init_pixelsv()
    // br label %2
    builder.SetInsertPoint(bblock0);
    llvm::AllocaInst *val_data1 = builder.CreateAlloca(builder.getInt32Ty());
    val_data1->setAlignment(llvm::MaybeAlign(4));
    builder.CreateAlignedStore(llvm::ConstantInt::get(builder.getInt32Ty(), 0), val_data1, llvm::MaybeAlign (4));
    
    llvm::FunctionType* init_windowTy = llvm::FunctionType::get (
        builder.getVoidTy(),
        {
            builder.getInt32Ty(),
            builder.getInt32Ty()
        }, 
        false
    );
    llvm::FunctionCallee init_windowCall = 
        module->getOrInsertFunction("_Z11init_windowjj", init_windowTy);
    builder.CreateCall(init_windowCall, {builder.getInt32(500), builder.getInt32(500)});

    llvm::FunctionType* init_pixelsTy = llvm::FunctionType::get(builder.getVoidTy(), false);
    llvm::FunctionCallee init_pixelsCall = 
        module->getOrInsertFunction("_Z11init_pixelsv", init_pixelsTy);
    builder.CreateCall(init_pixelsCall);

    builder.CreateBr(bblock2);

    // 2:                                                ; preds = %4, %0
    // %3 = call zeroext i1 @_Z14window_is_openv()
    // br i1 %3, label %4, label %5
    builder.SetInsertPoint(bblock2);

    llvm::FunctionType* window_is_openTy = llvm::FunctionType::get(builder.getInt1Ty(), false);
    llvm::FunctionCallee window_is_openCall =
        module->getOrInsertFunction("_Z14window_is_openv", window_is_openTy);
    llvm::CallBase *val_data3 = builder.CreateCall(window_is_openCall);
    val_data3->addAttribute(0, llvm::Attribute::ZExt);
    builder.CreateCondBr(val_data3, bblock4, bblock5);

    // 4:                                                ; preds = %2
    // call void @_Z12window_clearv()
    // call void @_Z6recalcv()
    // call void @_Z11check_eventv()
    // call void @_Z5flushv()
    // br label %2
    builder.SetInsertPoint(bblock4);

    llvm::FunctionType* window_clearTy = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::FunctionCallee window_clearCall =
        module->getOrInsertFunction("_Z12window_clearv", window_clearTy);
    builder.CreateCall(window_clearCall);

    llvm::FunctionType* recalcTy = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::FunctionCallee recalcCall =
        module->getOrInsertFunction("_Z6recalcv", recalcTy);
    builder.CreateCall(recalcCall);

    llvm::FunctionType* check_eventTy = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::FunctionCallee check_eventCall =
        module->getOrInsertFunction("_Z11check_eventv", check_eventTy);
    builder.CreateCall(check_eventCall);

    llvm::FunctionType* flushTy = llvm::FunctionType::get(builder.getVoidTy (), false);
    llvm::FunctionCallee flushCall =
        module->getOrInsertFunction("_Z5flushv", flushTy);
    builder.CreateCall(flushCall);

    builder.CreateBr(bblock2);

    // 5:                                                ; preds = %2
    // ret i32 0
    builder.SetInsertPoint(bblock5);
    builder.CreateRet(llvm::ConstantInt::get(builder.getInt32Ty(), 0));

    std::string s;
    llvm::raw_string_ostream os (s);
    module->print (os , nullptr);
    os.flush ();
    std::ofstream file;
    file.open ("ir_gen.ll");
    file << s;
    file.close ();
    // dump_codegen(module);
    // run(module);

    return 0;
}