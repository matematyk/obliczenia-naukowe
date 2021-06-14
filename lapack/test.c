
#include <stdlib.h>
#include <stdio.h>



/* Parameters */
#define N 2 /*The number of linear equations, i.e., the order of the */
#define NRHS 1 /*The number of right hand sides, i.e., the number of columns of the matrix B.  NRHS >= 0.*/
#define LDA 3 /*The leading dimension of the array A.  LDA >= max(1,N).*/
#define LDB 3 /*The leading dimension of the array B.  LDB >= max(1,N).*/



int nellspsv(double *a, double *b, int n, int nrhs, int lda, int ldb, int * ipiv, int info);

int main(){

        double a[LDA*N] = { /*5*5*/ /*3x2*/
            1, 1,
            1, 2,
            1, 3
        };
        double b[LDB*NRHS] = { /*3x5*/ /*3x1*/
            1, 
            1, 
            1,
        };
        int ipiv[N]; /* The pivot indices that define the permutation matrix P; */
        int info = 0;
        int status = nellspsv(a, b, N, NRHS, LDA, LDB, ipiv, info);

        printf("%d", status);
        

        return 1;
}
