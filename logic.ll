; ModuleID = 'logic.c'
source_filename = "logic.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @recalc([500 x i32]* noundef %0, [500 x i32]* noundef %1) #0 {
  %3 = alloca [500 x i32]*, align 8
  %4 = alloca [500 x i32]*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store [500 x i32]* %0, [500 x i32]** %3, align 8
  store [500 x i32]* %1, [500 x i32]** %4, align 8
  %12 = load [500 x i32]*, [500 x i32]** %3, align 8
  call void @put_pixels([500 x i32]* noundef %12)
  store i32 0, i32* %6, align 4
  br label %13

13:                                               ; preds = %136, %2
  %14 = load i32, i32* %6, align 4
  %15 = icmp slt i32 %14, 500
  br i1 %15, label %16, label %139

16:                                               ; preds = %13
  store i32 0, i32* %7, align 4
  br label %17

17:                                               ; preds = %132, %16
  %18 = load i32, i32* %7, align 4
  %19 = icmp slt i32 %18, 500
  br i1 %19, label %20, label %135

20:                                               ; preds = %17
  store i32 0, i32* %5, align 4
  %21 = load i32, i32* %6, align 4
  %22 = sub nsw i32 %21, 1
  store i32 %22, i32* %8, align 4
  br label %23

23:                                               ; preds = %75, %20
  %24 = load i32, i32* %8, align 4
  %25 = load i32, i32* %6, align 4
  %26 = add nsw i32 %25, 1
  %27 = icmp sle i32 %24, %26
  br i1 %27, label %28, label %78

28:                                               ; preds = %23
  %29 = load i32, i32* %7, align 4
  %30 = sub nsw i32 %29, 1
  store i32 %30, i32* %9, align 4
  br label %31

31:                                               ; preds = %71, %28
  %32 = load i32, i32* %9, align 4
  %33 = load i32, i32* %7, align 4
  %34 = add nsw i32 %33, 1
  %35 = icmp sle i32 %32, %34
  br i1 %35, label %36, label %74

36:                                               ; preds = %31
  %37 = load i32, i32* %8, align 4
  %38 = load i32, i32* %6, align 4
  %39 = icmp eq i32 %37, %38
  br i1 %39, label %40, label %44

40:                                               ; preds = %36
  %41 = load i32, i32* %9, align 4
  %42 = load i32, i32* %7, align 4
  %43 = icmp eq i32 %41, %42
  br i1 %43, label %56, label %44

44:                                               ; preds = %40, %36
  %45 = load i32, i32* %8, align 4
  %46 = icmp slt i32 %45, 0
  br i1 %46, label %56, label %47

47:                                               ; preds = %44
  %48 = load i32, i32* %9, align 4
  %49 = icmp slt i32 %48, 0
  br i1 %49, label %56, label %50

50:                                               ; preds = %47
  %51 = load i32, i32* %8, align 4
  %52 = icmp sge i32 %51, 500
  br i1 %52, label %56, label %53

53:                                               ; preds = %50
  %54 = load i32, i32* %9, align 4
  %55 = icmp sge i32 %54, 500
  br i1 %55, label %56, label %57

56:                                               ; preds = %53, %50, %47, %44, %40
  br label %71

57:                                               ; preds = %53
  %58 = load [500 x i32]*, [500 x i32]** %3, align 8
  %59 = load i32, i32* %8, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [500 x i32], [500 x i32]* %58, i64 %60
  %62 = load i32, i32* %9, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [500 x i32], [500 x i32]* %61, i64 0, i64 %63
  %65 = load i32, i32* %64, align 4
  %66 = icmp eq i32 %65, 1
  br i1 %66, label %67, label %70

67:                                               ; preds = %57
  %68 = load i32, i32* %5, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, i32* %5, align 4
  br label %70

70:                                               ; preds = %67, %57
  br label %71

71:                                               ; preds = %70, %56
  %72 = load i32, i32* %9, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, i32* %9, align 4
  br label %31, !llvm.loop !6

74:                                               ; preds = %31
  br label %75

75:                                               ; preds = %74
  %76 = load i32, i32* %8, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, i32* %8, align 4
  br label %23, !llvm.loop !8

78:                                               ; preds = %23
  %79 = load [500 x i32]*, [500 x i32]** %3, align 8
  %80 = load i32, i32* %6, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [500 x i32], [500 x i32]* %79, i64 %81
  %83 = load i32, i32* %7, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [500 x i32], [500 x i32]* %82, i64 0, i64 %84
  %86 = load i32, i32* %85, align 4
  %87 = icmp eq i32 %86, 1
  br i1 %87, label %88, label %102

88:                                               ; preds = %78
  %89 = load i32, i32* %5, align 4
  %90 = icmp eq i32 %89, 2
  br i1 %90, label %94, label %91

91:                                               ; preds = %88
  %92 = load i32, i32* %5, align 4
  %93 = icmp eq i32 %92, 3
  br i1 %93, label %94, label %102

94:                                               ; preds = %91, %88
  %95 = load [500 x i32]*, [500 x i32]** %4, align 8
  %96 = load i32, i32* %6, align 4
  %97 = sext i32 %96 to i64
  %98 = getelementptr inbounds [500 x i32], [500 x i32]* %95, i64 %97
  %99 = load i32, i32* %7, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [500 x i32], [500 x i32]* %98, i64 0, i64 %100
  store i32 1, i32* %101, align 4
  br label %132

102:                                              ; preds = %91, %78
  %103 = load [500 x i32]*, [500 x i32]** %3, align 8
  %104 = load i32, i32* %6, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [500 x i32], [500 x i32]* %103, i64 %105
  %107 = load i32, i32* %7, align 4
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds [500 x i32], [500 x i32]* %106, i64 0, i64 %108
  %110 = load i32, i32* %109, align 4
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %123

112:                                              ; preds = %102
  %113 = load i32, i32* %5, align 4
  %114 = icmp eq i32 %113, 3
  br i1 %114, label %115, label %123

115:                                              ; preds = %112
  %116 = load [500 x i32]*, [500 x i32]** %4, align 8
  %117 = load i32, i32* %6, align 4
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [500 x i32], [500 x i32]* %116, i64 %118
  %120 = load i32, i32* %7, align 4
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds [500 x i32], [500 x i32]* %119, i64 0, i64 %121
  store i32 1, i32* %122, align 4
  br label %132

123:                                              ; preds = %112, %102
  %124 = load [500 x i32]*, [500 x i32]** %4, align 8
  %125 = load i32, i32* %6, align 4
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds [500 x i32], [500 x i32]* %124, i64 %126
  %128 = load i32, i32* %7, align 4
  %129 = sext i32 %128 to i64
  %130 = getelementptr inbounds [500 x i32], [500 x i32]* %127, i64 0, i64 %129
  store i32 0, i32* %130, align 4
  br label %131

131:                                              ; preds = %123
  br label %132

132:                                              ; preds = %131, %115, %94
  %133 = load i32, i32* %7, align 4
  %134 = add nsw i32 %133, 1
  store i32 %134, i32* %7, align 4
  br label %17, !llvm.loop !9

135:                                              ; preds = %17
  br label %136

136:                                              ; preds = %135
  %137 = load i32, i32* %6, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, i32* %6, align 4
  br label %13, !llvm.loop !10

139:                                              ; preds = %13
  store i32 0, i32* %10, align 4
  br label %140

140:                                              ; preds = %167, %139
  %141 = load i32, i32* %10, align 4
  %142 = icmp slt i32 %141, 500
  br i1 %142, label %143, label %170

143:                                              ; preds = %140
  store i32 0, i32* %11, align 4
  br label %144

144:                                              ; preds = %163, %143
  %145 = load i32, i32* %11, align 4
  %146 = icmp slt i32 %145, 500
  br i1 %146, label %147, label %166

147:                                              ; preds = %144
  %148 = load [500 x i32]*, [500 x i32]** %4, align 8
  %149 = load i32, i32* %10, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds [500 x i32], [500 x i32]* %148, i64 %150
  %152 = load i32, i32* %11, align 4
  %153 = sext i32 %152 to i64
  %154 = getelementptr inbounds [500 x i32], [500 x i32]* %151, i64 0, i64 %153
  %155 = load i32, i32* %154, align 4
  %156 = load [500 x i32]*, [500 x i32]** %3, align 8
  %157 = load i32, i32* %10, align 4
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds [500 x i32], [500 x i32]* %156, i64 %158
  %160 = load i32, i32* %11, align 4
  %161 = sext i32 %160 to i64
  %162 = getelementptr inbounds [500 x i32], [500 x i32]* %159, i64 0, i64 %161
  store i32 %155, i32* %162, align 4
  br label %163

163:                                              ; preds = %147
  %164 = load i32, i32* %11, align 4
  %165 = add nsw i32 %164, 1
  store i32 %165, i32* %11, align 4
  br label %144, !llvm.loop !11

166:                                              ; preds = %144
  br label %167

167:                                              ; preds = %166
  %168 = load i32, i32* %10, align 4
  %169 = add nsw i32 %168, 1
  store i32 %169, i32* %10, align 4
  br label %140, !llvm.loop !12

170:                                              ; preds = %140
  ret void
}

declare void @put_pixels([500 x i32]* noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init_pixels([500 x i32]* noundef %0) #0 {
  %2 = alloca [500 x i32]*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store [500 x i32]* %0, [500 x i32]** %2, align 8
  store i32 0, i32* %3, align 4
  br label %5

5:                                                ; preds = %39, %1
  %6 = load i32, i32* %3, align 4
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %8, label %42

8:                                                ; preds = %5
  store i32 0, i32* %4, align 4
  br label %9

9:                                                ; preds = %35, %8
  %10 = load i32, i32* %4, align 4
  %11 = icmp slt i32 %10, 500
  br i1 %11, label %12, label %38

12:                                               ; preds = %9
  %13 = load i32, i32* %3, align 4
  %14 = load i32, i32* %4, align 4
  %15 = add nsw i32 %13, %14
  %16 = srem i32 %15, 3
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %26

18:                                               ; preds = %12
  %19 = load [500 x i32]*, [500 x i32]** %2, align 8
  %20 = load i32, i32* %3, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [500 x i32], [500 x i32]* %19, i64 %21
  %23 = load i32, i32* %4, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [500 x i32], [500 x i32]* %22, i64 0, i64 %24
  store i32 1, i32* %25, align 4
  br label %34

26:                                               ; preds = %12
  %27 = load [500 x i32]*, [500 x i32]** %2, align 8
  %28 = load i32, i32* %3, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [500 x i32], [500 x i32]* %27, i64 %29
  %31 = load i32, i32* %4, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [500 x i32], [500 x i32]* %30, i64 0, i64 %32
  store i32 0, i32* %33, align 4
  br label %34

34:                                               ; preds = %26, %18
  br label %35

35:                                               ; preds = %34
  %36 = load i32, i32* %4, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %4, align 4
  br label %9, !llvm.loop !13

38:                                               ; preds = %9
  br label %39

39:                                               ; preds = %38
  %40 = load i32, i32* %3, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %3, align 4
  br label %5, !llvm.loop !14

42:                                               ; preds = %5
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
