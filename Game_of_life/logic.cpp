#include "logic.h"

void recalc(int **a, int **b, int row, int col) {
    int neighbour_live_cell;
    for(int i=0; i<row; i++){
        for(int j=0;j<col;j++){
            neighbour_live_cell = 0;
            for(int i1=i-1; i1<=i+1; i1++){
                for(int j1=j-1;j1<=j+1;j1++){
                    if((i1==i && j1==j) || (i1<0 || j1<0) || (i1>=row || j1>=col)){
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
}
