; ModuleID = 'main'
source_filename = "main"
target triple = "x86_64-pc-linux-gnu"

@a = internal global [500 x [500 x i32]] zeroinitializer
@b = internal global [500 x [500 x i32]] zeroinitializer
@neighbour_live_cell = internal global i32 0
@i = internal global i32 0
@j = internal global i32 0
@i1 = internal global i32 0
@j1 = internal global i32 0
@while_num = internal global i32 0
@cond_check = internal global i32 0

declare void @_Z12window_clearv()

declare void @_Z11check_eventv()

declare void @_Z5flushv()

declare void @print(i32)

declare void @_Z11init_windowjj(i32, i32)

declare void @put_pixel(i32, i32, i32)

define void @main() {
entry:
  call void @_Z11init_windowjj(i32 500, i32 500)
  store i32 0, i32* @i
  br label %0

0:                                                ; preds = %8, %entry
  %1 = load i32, i32* @i
  %2 = icmp slt i32 %1, 500
  br i1 %2, label %4, label %3

3:                                                ; preds = %0
  store i32 0, i32* @cond_check
  store i32 1, i32* @while_num
  br label %38

4:                                                ; preds = %0
  store i32 0, i32* @j
  br label %5

5:                                                ; preds = %35, %4
  %6 = load i32, i32* @j
  %7 = icmp slt i32 %6, 500
  br i1 %7, label %11, label %8

8:                                                ; preds = %5
  %9 = load i32, i32* @i
  %10 = add i32 %9, 1
  store i32 %10, i32* @i
  br label %0

11:                                               ; preds = %5
  %12 = load i32, i32* @i
  %13 = load i32, i32* @j
  %14 = add i32 %12, %13
  %15 = srem i32 %14, 3
  %16 = icmp eq i32 %15, 0
  %17 = zext i1 %16 to i32
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %23

19:                                               ; preds = %11
  %20 = load i32, i32* @i
  %21 = load i32, i32* @j
  %22 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %20, i32 %21
  store i32 1, i32* %22
  br label %23

23:                                               ; preds = %19, %11
  %24 = load i32, i32* @i
  %25 = load i32, i32* @j
  %26 = add i32 %24, %25
  %27 = srem i32 %26, 3
  %28 = icmp ne i32 %27, 0
  %29 = zext i1 %28 to i32
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %35

31:                                               ; preds = %23
  %32 = load i32, i32* @i
  %33 = load i32, i32* @j
  %34 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %32, i32 %33
  store i32 0, i32* %34
  br label %35

35:                                               ; preds = %31, %23
  %36 = load i32, i32* @j
  %37 = add i32 %36, 1
  store i32 %37, i32* @j
  br label %5

38:                                               ; preds = %194, %3
  %39 = load i32, i32* @while_num
  %40 = icmp slt i32 %39, 5
  %41 = zext i1 %40 to i32
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %44, label %43

43:                                               ; preds = %38
  ret void

44:                                               ; preds = %38
  call void @_Z12window_clearv()
  store i32 0, i32* @i
  br label %45

45:                                               ; preds = %53, %44
  %46 = load i32, i32* @i
  %47 = icmp slt i32 %46, 500
  br i1 %47, label %49, label %48

48:                                               ; preds = %45
  store i32 0, i32* @i
  br label %191

49:                                               ; preds = %45
  store i32 0, i32* @j
  br label %50

50:                                               ; preds = %188, %49
  %51 = load i32, i32* @j
  %52 = icmp slt i32 %51, 500
  br i1 %52, label %56, label %53

53:                                               ; preds = %50
  %54 = load i32, i32* @i
  %55 = add i32 %54, 1
  store i32 %55, i32* @i
  br label %45

56:                                               ; preds = %50
  %57 = load i32, i32* @i
  %58 = load i32, i32* @j
  %59 = load i32, i32* @i
  %60 = load i32, i32* @j
  %61 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %59, i32 %60
  %62 = load i32, i32* %61
  call void @put_pixel(i32 %57, i32 %58, i32 %62)
  store i32 0, i32* @neighbour_live_cell
  %63 = load i32, i32* @i
  %64 = sub i32 %63, 1
  %65 = load i32, i32* @i
  %66 = add i32 %65, 2
  store i32 %64, i32* @i1
  br label %67

67:                                               ; preds = %90, %56
  %68 = load i32, i32* @i1
  %69 = icmp slt i32 %68, %66
  br i1 %69, label %82, label %70

70:                                               ; preds = %67
  store i32 0, i32* @cond_check
  %71 = load i32, i32* @i
  %72 = load i32, i32* @j
  %73 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %71, i32 %72
  %74 = load i32, i32* %73
  %75 = icmp eq i32 %74, 1
  %76 = zext i1 %75 to i32
  %77 = load i32, i32* @neighbour_live_cell
  %78 = icmp eq i32 %77, 2
  %79 = zext i1 %78 to i32
  %80 = and i32 %76, %79
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %143, label %147

82:                                               ; preds = %67
  %83 = load i32, i32* @j
  %84 = sub i32 %83, 1
  %85 = load i32, i32* @j
  %86 = add i32 %85, 2
  store i32 %84, i32* @j1
  br label %87

87:                                               ; preds = %140, %82
  %88 = load i32, i32* @j1
  %89 = icmp slt i32 %88, %86
  br i1 %89, label %93, label %90

90:                                               ; preds = %87
  %91 = load i32, i32* @i1
  %92 = add i32 %91, 1
  store i32 %92, i32* @i1
  br label %67

93:                                               ; preds = %87
  store i32 0, i32* @cond_check
  %94 = load i32, i32* @i1
  %95 = load i32, i32* @i
  %96 = icmp eq i32 %94, %95
  %97 = zext i1 %96 to i32
  %98 = load i32, i32* @j1
  %99 = load i32, i32* @j
  %100 = icmp eq i32 %98, %99
  %101 = zext i1 %100 to i32
  %102 = and i32 %97, %101
  %103 = icmp ne i32 %102, 0
  br i1 %103, label %104, label %105

104:                                              ; preds = %93
  store i32 1, i32* @cond_check
  br label %105

105:                                              ; preds = %104, %93
  %106 = load i32, i32* @i1
  %107 = icmp slt i32 %106, 0
  %108 = zext i1 %107 to i32
  %109 = load i32, i32* @j1
  %110 = icmp slt i32 %109, 0
  %111 = zext i1 %110 to i32
  %112 = or i32 %108, %111
  %113 = icmp ne i32 %112, 0
  br i1 %113, label %114, label %115

114:                                              ; preds = %105
  store i32 1, i32* @cond_check
  br label %115

115:                                              ; preds = %114, %105
  %116 = load i32, i32* @i1
  %117 = icmp sge i32 %116, 500
  %118 = zext i1 %117 to i32
  %119 = load i32, i32* @j1
  %120 = icmp sge i32 %119, 500
  %121 = zext i1 %120 to i32
  %122 = or i32 %118, %121
  %123 = icmp ne i32 %122, 0
  br i1 %123, label %124, label %125

124:                                              ; preds = %115
  store i32 1, i32* @cond_check
  br label %125

125:                                              ; preds = %124, %115
  %126 = load i32, i32* @i1
  %127 = load i32, i32* @j1
  %128 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %126, i32 %127
  %129 = load i32, i32* %128
  %130 = icmp eq i32 %129, 1
  %131 = zext i1 %130 to i32
  %132 = load i32, i32* @cond_check
  %133 = icmp eq i32 %132, 0
  %134 = zext i1 %133 to i32
  %135 = and i32 %131, %134
  %136 = icmp ne i32 %135, 0
  br i1 %136, label %137, label %140

137:                                              ; preds = %125
  %138 = load i32, i32* @neighbour_live_cell
  %139 = add i32 %138, 1
  store i32 %139, i32* @neighbour_live_cell
  br label %140

140:                                              ; preds = %137, %125
  store i32 0, i32* @cond_check
  %141 = load i32, i32* @j1
  %142 = add i32 %141, 1
  store i32 %142, i32* @j1
  br label %87

143:                                              ; preds = %70
  %144 = load i32, i32* @i
  %145 = load i32, i32* @j
  %146 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @b, i32 0, i32 %144, i32 %145
  store i32 1, i32* %146
  store i32 1, i32* @cond_check
  br label %147

147:                                              ; preds = %143, %70
  %148 = load i32, i32* @i
  %149 = load i32, i32* @j
  %150 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %148, i32 %149
  %151 = load i32, i32* %150
  %152 = icmp eq i32 %151, 1
  %153 = zext i1 %152 to i32
  %154 = load i32, i32* @neighbour_live_cell
  %155 = icmp eq i32 %154, 3
  %156 = zext i1 %155 to i32
  %157 = and i32 %153, %156
  %158 = icmp ne i32 %157, 0
  br i1 %158, label %159, label %163

159:                                              ; preds = %147
  %160 = load i32, i32* @i
  %161 = load i32, i32* @j
  %162 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @b, i32 0, i32 %160, i32 %161
  store i32 1, i32* %162
  store i32 1, i32* @cond_check
  br label %163

163:                                              ; preds = %159, %147
  %164 = load i32, i32* @i
  %165 = load i32, i32* @j
  %166 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %164, i32 %165
  %167 = load i32, i32* %166
  %168 = icmp eq i32 %167, 0
  %169 = zext i1 %168 to i32
  %170 = load i32, i32* @neighbour_live_cell
  %171 = icmp eq i32 %170, 3
  %172 = zext i1 %171 to i32
  %173 = and i32 %169, %172
  %174 = icmp ne i32 %173, 0
  br i1 %174, label %175, label %179

175:                                              ; preds = %163
  %176 = load i32, i32* @i
  %177 = load i32, i32* @j
  %178 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @b, i32 0, i32 %176, i32 %177
  store i32 1, i32* %178
  store i32 1, i32* @cond_check
  br label %179

179:                                              ; preds = %175, %163
  %180 = load i32, i32* @cond_check
  %181 = icmp eq i32 %180, 0
  %182 = zext i1 %181 to i32
  %183 = icmp ne i32 %182, 0
  br i1 %183, label %184, label %188

184:                                              ; preds = %179
  %185 = load i32, i32* @i
  %186 = load i32, i32* @j
  %187 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @b, i32 0, i32 %185, i32 %186
  store i32 0, i32* %187
  br label %188

188:                                              ; preds = %184, %179
  store i32 0, i32* @cond_check
  %189 = load i32, i32* @j
  %190 = add i32 %189, 1
  store i32 %190, i32* @j
  br label %50

191:                                              ; preds = %199, %48
  %192 = load i32, i32* @i
  %193 = icmp slt i32 %192, 500
  br i1 %193, label %195, label %194

194:                                              ; preds = %191
  call void @_Z11check_eventv()
  call void @_Z5flushv()
  br label %38

195:                                              ; preds = %191
  store i32 0, i32* @j
  br label %196

196:                                              ; preds = %202, %195
  %197 = load i32, i32* @j
  %198 = icmp slt i32 %197, 500
  br i1 %198, label %202, label %199

199:                                              ; preds = %196
  %200 = load i32, i32* @i
  %201 = add i32 %200, 1
  store i32 %201, i32* @i
  br label %191

202:                                              ; preds = %196
  %203 = load i32, i32* @i
  %204 = load i32, i32* @j
  %205 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @a, i32 0, i32 %203, i32 %204
  %206 = load i32, i32* @i
  %207 = load i32, i32* @j
  %208 = getelementptr [500 x [500 x i32]], [500 x [500 x i32]]* @b, i32 0, i32 %206, i32 %207
  %209 = load i32, i32* %208
  store i32 %209, i32* %205
  %210 = load i32, i32* @j
  %211 = add i32 %210, 1
  store i32 %211, i32* @j
  br label %196
}