#include "logic.h"
#include "common.h"
#include "stdlib.h"

void recalc(int a[ROW][COL], int b[ROW][COL]) {
    int neighbour_live_cell;
    for(int i=0; i<ROW; i++){
        for(int j=0;j<COL;j++){
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

void init_pixels(int a[ROW][COL]) {
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
}

