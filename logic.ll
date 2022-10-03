; ModuleID = 'logic.c'
source_filename = "logic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @recalc(i32** noundef %0, i32** noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32**, align 8
  %6 = alloca i32**, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32** %0, i32*** %5, align 8
  store i32** %1, i32*** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  store i32 0, i32* %10, align 4
  br label %14

14:                                               ; preds = %147, %4
  %15 = load i32, i32* %10, align 4
  %16 = load i32, i32* %7, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %150

18:                                               ; preds = %14
  store i32 0, i32* %11, align 4
  br label %19

19:                                               ; preds = %143, %18
  %20 = load i32, i32* %11, align 4
  %21 = load i32, i32* %8, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %146

23:                                               ; preds = %19
  store i32 0, i32* %9, align 4
  %24 = load i32, i32* %10, align 4
  %25 = sub nsw i32 %24, 1
  store i32 %25, i32* %12, align 4
  br label %26

26:                                               ; preds = %81, %23
  %27 = load i32, i32* %12, align 4
  %28 = load i32, i32* %10, align 4
  %29 = add nsw i32 %28, 1
  %30 = icmp sle i32 %27, %29
  br i1 %30, label %31, label %84

31:                                               ; preds = %26
  %32 = load i32, i32* %11, align 4
  %33 = sub nsw i32 %32, 1
  store i32 %33, i32* %13, align 4
  br label %34

34:                                               ; preds = %77, %31
  %35 = load i32, i32* %13, align 4
  %36 = load i32, i32* %11, align 4
  %37 = add nsw i32 %36, 1
  %38 = icmp sle i32 %35, %37
  br i1 %38, label %39, label %80

39:                                               ; preds = %34
  %40 = load i32, i32* %12, align 4
  %41 = load i32, i32* %10, align 4
  %42 = icmp eq i32 %40, %41
  br i1 %42, label %43, label %47

43:                                               ; preds = %39
  %44 = load i32, i32* %13, align 4
  %45 = load i32, i32* %11, align 4
  %46 = icmp eq i32 %44, %45
  br i1 %46, label %61, label %47

47:                                               ; preds = %43, %39
  %48 = load i32, i32* %12, align 4
  %49 = icmp slt i32 %48, 0
  br i1 %49, label %61, label %50

50:                                               ; preds = %47
  %51 = load i32, i32* %13, align 4
  %52 = icmp slt i32 %51, 0
  br i1 %52, label %61, label %53

53:                                               ; preds = %50
  %54 = load i32, i32* %12, align 4
  %55 = load i32, i32* %7, align 4
  %56 = icmp sge i32 %54, %55
  br i1 %56, label %61, label %57

57:                                               ; preds = %53
  %58 = load i32, i32* %13, align 4
  %59 = load i32, i32* %8, align 4
  %60 = icmp sge i32 %58, %59
  br i1 %60, label %61, label %62

61:                                               ; preds = %57, %53, %50, %47, %43
  br label %77

62:                                               ; preds = %57
  %63 = load i32**, i32*** %5, align 8
  %64 = load i32, i32* %12, align 4
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds i32*, i32** %63, i64 %65
  %67 = load i32*, i32** %66, align 8
  %68 = load i32, i32* %13, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds i32, i32* %67, i64 %69
  %71 = load i32, i32* %70, align 4
  %72 = icmp eq i32 %71, 1
  br i1 %72, label %73, label %76

73:                                               ; preds = %62
  %74 = load i32, i32* %9, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, i32* %9, align 4
  br label %76

76:                                               ; preds = %73, %62
  br label %77

77:                                               ; preds = %76, %61
  %78 = load i32, i32* %13, align 4
  %79 = add nsw i32 %78, 1
  store i32 %79, i32* %13, align 4
  br label %34, !llvm.loop !6

80:                                               ; preds = %34
  br label %81

81:                                               ; preds = %80
  %82 = load i32, i32* %12, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, i32* %12, align 4
  br label %26, !llvm.loop !8

84:                                               ; preds = %26
  %85 = load i32**, i32*** %5, align 8
  %86 = load i32, i32* %10, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds i32*, i32** %85, i64 %87
  %89 = load i32*, i32** %88, align 8
  %90 = load i32, i32* %11, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i32, i32* %89, i64 %91
  %93 = load i32, i32* %92, align 4
  %94 = icmp eq i32 %93, 1
  br i1 %94, label %95, label %110

95:                                               ; preds = %84
  %96 = load i32, i32* %9, align 4
  %97 = icmp eq i32 %96, 2
  br i1 %97, label %101, label %98

98:                                               ; preds = %95
  %99 = load i32, i32* %9, align 4
  %100 = icmp eq i32 %99, 3
  br i1 %100, label %101, label %110

101:                                              ; preds = %98, %95
  %102 = load i32**, i32*** %6, align 8
  %103 = load i32, i32* %10, align 4
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds i32*, i32** %102, i64 %104
  %106 = load i32*, i32** %105, align 8
  %107 = load i32, i32* %11, align 4
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds i32, i32* %106, i64 %108
  store i32 1, i32* %109, align 4
  br label %143

110:                                              ; preds = %98, %84
  %111 = load i32**, i32*** %5, align 8
  %112 = load i32, i32* %10, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds i32*, i32** %111, i64 %113
  %115 = load i32*, i32** %114, align 8
  %116 = load i32, i32* %11, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds i32, i32* %115, i64 %117
  %119 = load i32, i32* %118, align 4
  %120 = icmp eq i32 %119, 0
  br i1 %120, label %121, label %133

121:                                              ; preds = %110
  %122 = load i32, i32* %9, align 4
  %123 = icmp eq i32 %122, 3
  br i1 %123, label %124, label %133

124:                                              ; preds = %121
  %125 = load i32**, i32*** %6, align 8
  %126 = load i32, i32* %10, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds i32*, i32** %125, i64 %127
  %129 = load i32*, i32** %128, align 8
  %130 = load i32, i32* %11, align 4
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds i32, i32* %129, i64 %131
  store i32 1, i32* %132, align 4
  br label %143

133:                                              ; preds = %121, %110
  %134 = load i32**, i32*** %6, align 8
  %135 = load i32, i32* %10, align 4
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds i32*, i32** %134, i64 %136
  %138 = load i32*, i32** %137, align 8
  %139 = load i32, i32* %11, align 4
  %140 = sext i32 %139 to i64
  %141 = getelementptr inbounds i32, i32* %138, i64 %140
  store i32 0, i32* %141, align 4
  br label %142

142:                                              ; preds = %133
  br label %143

143:                                              ; preds = %142, %124, %101
  %144 = load i32, i32* %11, align 4
  %145 = add nsw i32 %144, 1
  store i32 %145, i32* %11, align 4
  br label %19, !llvm.loop !9

146:                                              ; preds = %19
  br label %147

147:                                              ; preds = %146
  %148 = load i32, i32* %10, align 4
  %149 = add nsw i32 %148, 1
  store i32 %149, i32* %10, align 4
  br label %14, !llvm.loop !10

150:                                              ; preds = %14
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
