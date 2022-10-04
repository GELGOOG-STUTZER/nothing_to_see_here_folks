#include "graphics.h"
#include "logic.h"
#include "common.h"

int main(){
    int a[ROW][COL];
    int b[ROW][COL];

    init_window(COL, ROW);
    init_pixels(a);

    while (window_is_open()) {
        window_clear();
        put_pixels(a);
        recalc(a, b);
        check_event();
        flush();
    }
    return 0;
}