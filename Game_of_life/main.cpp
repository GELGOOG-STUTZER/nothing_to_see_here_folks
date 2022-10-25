#include "graphics.h"

#define ROW 500
#define COL 500

int a[ROW][COL];
int b[ROW][COL];

void recalc() {
    int neighbour_live_cell;
    for(int i=0; i<ROW; i++){
        for(int j=0;j<COL;j++){
            put_pixel(i, j, a[i][j]);
            neighbour_live_cell = 0;
            for(int i1=i-1; i1<=i+1; i1++){
                for(int j1=j-1;j1<=j+1;j1++){
                    if((i1==i && j1==j) || (i1<0 || j1<0) || (i1>=ROW || j1>=COL)){
                        continue;
                    }
                    if(a[i1][j1]==1){
                        neighbour_live_cell++;
                    }
                }
            }

            if(a[i][j]==1 && (neighbour_live_cell==2 || neighbour_live_cell==3)){
                b[i][j]=1;
                continue;
            }

            if(a[i][j]==0 && neighbour_live_cell==3){
                b[i][j]=1;
                continue;
            }

            else{
                b[i][j]=0;
            }
        }
    }
    for(int i=0; i<ROW; i++){
        for(int j=0; j<ROW; j++){
            a[i][j] = b[i][j];
        }
    }
}

void init_pixels() {
    int i,j;
    for(i=0; i<ROW; i++){
        for(j=0;j<COL;j++){
            if ((i + j) % 3 == 0) {
                a[i][j] = 1;
            }
            else {
                a[i][j] = 0;
            }
        }
    }
}

int main(){

    init_window(COL, ROW);
    init_pixels();

    while (window_is_open()) {
        window_clear();
        recalc();
        check_event();
        flush();
    }
    return 0;
}