#include <stdlib.h>
#include "graphics.h"
#include "logic.h"

int main(){
    int **a;
    int **b;

    init_window(COL, ROW);

    a = (int**) malloc(ROW * sizeof(int*) + COL * ROW * sizeof(int));
    a[0] = (int*)(a + ROW);
    for (int i = 1; i < ROW; i++) {
        a[i] = a[0] + i * COL;
    }
    b = (int**) malloc(ROW * sizeof(int*) + COL * ROW * sizeof(int));
    b[0] = (int*)(b + ROW);
    for (int i = 1; i < ROW; i++) {
        b[i] = b[0] + i * COL;
    }

    int i,j;
    for(i=0; i<ROW; i++){
        for(j=0;j<COL;j++){
            if (rand() % 2 == 0) { // NOLINT(cert-msc50-cpp)
                a[i][j] = 1;
            }
            else {
                a[i][j] = 0;
            }
        }
    }

    int phase_check = 0;
    while (window_is_open()) {
        window_clear();
        if(phase_check == 0) {
            put_pixels(a);
            recalc(a, b, ROW, COL);
        }
        else {
            put_pixels(b);
            recalc(b, a, ROW, COL);
        }
        phase_check = (phase_check + 1) % 2;
        check_event();
        flush();
    }
    free(a);
    free(b);
    return 0;
}