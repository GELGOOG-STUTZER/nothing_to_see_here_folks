; ModuleID = 'main.cpp'
source_filename = "main.cpp"

@a = dso_local global [500 x [500 x i32]] zeroinitializer, align 16
@b = dso_local global [500 x [500 x i32]] zeroinitializer, align 16

declare dso_local void @put_pixel(i32, i32, i32)

declare dso_local void @_Z11init_windowjj(i32, i32)

declare dso_local void @_Z11check_eventv()

declare dso_local void @_Z12window_clearv()

declare dso_local void @_Z5flushv()

declare dso_local zeroext i1 @_Z14window_is_openv()

define dso_local void @_Z6recalcv() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, i32* %2, align 4
  br label %8

8:                                                ; preds = %134, %0
  %9 = load i32, i32* %2, align 4
  %10 = icmp slt i32 %9, 500
  br i1 %10, label %11, label %137

11:                                               ; preds = %8
  store i32 0, i32* %3, align 4
  br label %12

12:                                               ; preds = %130, %11
  %13 = load i32, i32* %3, align 4
  %14 = icmp slt i32 %13, 500
  br i1 %14, label %15, label %133

15:                                               ; preds = %12
  %16 = load i32, i32* %2, align 4
  %17 = load i32, i32* %3, align 4
  %18 = load i32, i32* %2, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %19
  %21 = load i32, i32* %3, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [500 x i32], [500 x i32]* %20, i64 0, i64 %22
  %24 = load i32, i32* %23, align 4
  call void @put_pixel(i32 %16, i32 %17, i32 %24)
  store i32 0, i32* %1, align 4
  %25 = load i32, i32* %2, align 4
  %26 = sub nsw i32 %25, 1
  store i32 %26, i32* %4, align 4
  br label %27

27:                                               ; preds = %78, %15
  %28 = load i32, i32* %4, align 4
  %29 = load i32, i32* %2, align 4
  %30 = add nsw i32 %29, 1
  %31 = icmp sle i32 %28, %30
  br i1 %31, label %32, label %81

32:                                               ; preds = %27
  %33 = load i32, i32* %3, align 4
  %34 = sub nsw i32 %33, 1
  store i32 %34, i32* %5, align 4
  br label %35

35:                                               ; preds = %74, %32
  %36 = load i32, i32* %5, align 4
  %37 = load i32, i32* %3, align 4
  %38 = add nsw i32 %37, 1
  %39 = icmp sle i32 %36, %38
  br i1 %39, label %40, label %77

40:                                               ; preds = %35
  %41 = load i32, i32* %4, align 4
  %42 = load i32, i32* %2, align 4
  %43 = icmp eq i32 %41, %42
  br i1 %43, label %44, label %48

44:                                               ; preds = %40
  %45 = load i32, i32* %5, align 4
  %46 = load i32, i32* %3, align 4
  %47 = icmp eq i32 %45, %46
  br i1 %47, label %60, label %48

48:                                               ; preds = %44, %40
  %49 = load i32, i32* %4, align 4
  %50 = icmp slt i32 %49, 0
  br i1 %50, label %60, label %51

51:                                               ; preds = %48
  %52 = load i32, i32* %5, align 4
  %53 = icmp slt i32 %52, 0
  br i1 %53, label %60, label %54

54:                                               ; preds = %51
  %55 = load i32, i32* %4, align 4
  %56 = icmp sge i32 %55, 500
  br i1 %56, label %60, label %57

57:                                               ; preds = %54
  %58 = load i32, i32* %5, align 4
  %59 = icmp sge i32 %58, 500
  br i1 %59, label %60, label %61

60:                                               ; preds = %57, %54, %51, %48, %44
  br label %74

61:                                               ; preds = %57
  %62 = load i32, i32* %4, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %63
  %65 = load i32, i32* %5, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [500 x i32], [500 x i32]* %64, i64 0, i64 %66
  %68 = load i32, i32* %67, align 4
  %69 = icmp eq i32 %68, 1
  br i1 %69, label %70, label %73

70:                                               ; preds = %61
  %71 = load i32, i32* %1, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, i32* %1, align 4
  br label %73

73:                                               ; preds = %70, %61
  br label %74

74:                                               ; preds = %73, %60
  %75 = load i32, i32* %5, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, i32* %5, align 4
  br label %35

77:                                               ; preds = %35
  br label %78

78:                                               ; preds = %77
  %79 = load i32, i32* %4, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, i32* %4, align 4
  br label %27

81:                                               ; preds = %27
  %82 = load i32, i32* %2, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %83
  %85 = load i32, i32* %3, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [500 x i32], [500 x i32]* %84, i64 0, i64 %86
  %88 = load i32, i32* %87, align 4
  %89 = icmp eq i32 %88, 1
  br i1 %89, label %90, label %103

90:                                               ; preds = %81
  %91 = load i32, i32* %1, align 4
  %92 = icmp eq i32 %91, 2
  br i1 %92, label %96, label %93

93:                                               ; preds = %90
  %94 = load i32, i32* %1, align 4
  %95 = icmp eq i32 %94, 3
  br i1 %95, label %96, label %103

96:                                               ; preds = %93, %90
  %97 = load i32, i32* %2, align 4
  %98 = sext i32 %97 to i64
  %99 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %98
  %100 = load i32, i32* %3, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [500 x i32], [500 x i32]* %99, i64 0, i64 %101
  store i32 1, i32* %102, align 4
  br label %130

103:                                              ; preds = %93, %81
  %104 = load i32, i32* %2, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %105
  %107 = load i32, i32* %3, align 4
  %108 = sext i32 %107 to i64
  %109 = getelementptr inbounds [500 x i32], [500 x i32]* %106, i64 0, i64 %108
  %110 = load i32, i32* %109, align 4
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %122

112:                                              ; preds = %103
  %113 = load i32, i32* %1, align 4
  %114 = icmp eq i32 %113, 3
  br i1 %114, label %115, label %122

115:                                              ; preds = %112
  %116 = load i32, i32* %2, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %117
  %119 = load i32, i32* %3, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [500 x i32], [500 x i32]* %118, i64 0, i64 %120
  store i32 1, i32* %121, align 4
  br label %130

122:                                              ; preds = %112, %103
  %123 = load i32, i32* %2, align 4
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %124
  %126 = load i32, i32* %3, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds [500 x i32], [500 x i32]* %125, i64 0, i64 %127
  store i32 0, i32* %128, align 4
  br label %129

129:                                              ; preds = %122
  br label %130

130:                                              ; preds = %129, %115, %96
  %131 = load i32, i32* %3, align 4
  %132 = add nsw i32 %131, 1
  store i32 %132, i32* %3, align 4
  br label %12

133:                                              ; preds = %12
  br label %134

134:                                              ; preds = %133
  %135 = load i32, i32* %2, align 4
  %136 = add nsw i32 %135, 1
  store i32 %136, i32* %2, align 4
  br label %8

137:                                              ; preds = %8
  store i32 0, i32* %6, align 4
  br label %138

138:                                              ; preds = %163, %137
  %139 = load i32, i32* %6, align 4
  %140 = icmp slt i32 %139, 500
  br i1 %140, label %141, label %166

141:                                              ; preds = %138
  store i32 0, i32* %7, align 4
  br label %142

142:                                              ; preds = %159, %141
  %143 = load i32, i32* %7, align 4
  %144 = icmp slt i32 %143, 500
  br i1 %144, label %145, label %162

145:                                              ; preds = %142
  %146 = load i32, i32* %6, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @b, i64 0, i64 %147
  %149 = load i32, i32* %7, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds [500 x i32], [500 x i32]* %148, i64 0, i64 %150
  %152 = load i32, i32* %151, align 4
  %153 = load i32, i32* %6, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %154
  %156 = load i32, i32* %7, align 4
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds [500 x i32], [500 x i32]* %155, i64 0, i64 %157
  store i32 %152, i32* %158, align 4
  br label %159

159:                                              ; preds = %145
  %160 = load i32, i32* %7, align 4
  %161 = add nsw i32 %160, 1
  store i32 %161, i32* %7, align 4
  br label %142

162:                                              ; preds = %142
  br label %163

163:                                              ; preds = %162
  %164 = load i32, i32* %6, align 4
  %165 = add nsw i32 %164, 1
  store i32 %165, i32* %6, align 4
  br label %138

166:                                              ; preds = %138
  ret void
}

define dso_local void @_Z11init_pixelsv() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %3

3:                                                ; preds = %35, %0
  %4 = load i32, i32* %1, align 4
  %5 = icmp slt i32 %4, 500
  br i1 %5, label %6, label %38

6:                                                ; preds = %3
  store i32 0, i32* %2, align 4
  br label %7

7:                                                ; preds = %31, %6
  %8 = load i32, i32* %2, align 4
  %9 = icmp slt i32 %8, 500
  br i1 %9, label %10, label %34

10:                                               ; preds = %7
  %11 = load i32, i32* %1, align 4
  %12 = load i32, i32* %2, align 4
  %13 = add nsw i32 %11, %12
  %14 = srem i32 %13, 3
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %10
  %17 = load i32, i32* %1, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %18
  %20 = load i32, i32* %2, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [500 x i32], [500 x i32]* %19, i64 0, i64 %21
  store i32 1, i32* %22, align 4
  br label %30

23:                                               ; preds = %10
  %24 = load i32, i32* %1, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @a, i64 0, i64 %25
  %27 = load i32, i32* %2, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [500 x i32], [500 x i32]* %26, i64 0, i64 %28
  store i32 0, i32* %29, align 4
  br label %30

30:                                               ; preds = %23, %16
  br label %31

31:                                               ; preds = %30
  %32 = load i32, i32* %2, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %2, align 4
  br label %7

34:                                               ; preds = %7
  br label %35

35:                                               ; preds = %34
  %36 = load i32, i32* %1, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %1, align 4
  br label %3

38:                                               ; preds = %3
  ret void
}

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @_Z11init_windowjj(i32 500, i32 500)
  call void @_Z11init_pixelsv()
  br label %2

2:                                                ; preds = %4, %0
  %3 = call zeroext i1 @_Z14window_is_openv()
  br i1 %3, label %4, label %5

4:                                                ; preds = %2
  call void @_Z12window_clearv()
  call void @_Z6recalcv()
  call void @_Z11check_eventv()
  call void @_Z5flushv()
  br label %2

5:                                                ; preds = %2
  ret i32 0
}
