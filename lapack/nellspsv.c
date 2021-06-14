#include <stdlib.h>
#include <stdio.h>
/* DGESV prototype */
extern void dgesv_( int* n, int* nrhs, double* a, int* lda, int* ipiv,
                double* b, int* ldb, int* info );

/* Auxiliary routines prototypes */
extern void print_matrix( char* desc, int m, int n, double* a, int lda );

/* Main program */
int nellspsv(double *a, double *b, int N, int NRHS, int LDA, int LDB, int * ipiv, int INFO) {
        /* Executable statements */
        printf( " DGESV Example Program Results\n" );
        /* Solve the equations A*X = B */
        dgesv_( &N, &NRHS, a, &LDA, ipiv, b, &LDB, &INFO );
        /* Check for the exact singularity */
        if( INFO > 0 ) {
                printf( "The diagonal element of the triangular factor of A,\n" );
                printf( "U(%i,%i) is zero, so that A is singular;\n", INFO, INFO );
                printf( "the solution could not be computed.\n" );
                exit( 1 );
        }

        /* Print solution */
        print_matrix( "Solution", N, NRHS, b, LDB );

        exit(0);
} 



/* Auxiliary routine: printing a matrix */
void print_matrix( char* desc, int m, int n, double* a, int lda ) {
        int i, j;
        printf( "\n %s\n", desc );
        for( i = 0; i < m; i++ ) {
                for( j = 0; j < n; j++ ) printf( " %6.2f", a[i+j*lda] );
                printf( "\n" );
        }
}
