
#include "trafo.h"
#include "types.h"

//-----------------------------------------------------------------------------------
//Las funciones que se definan en ensamblador debrán borrarse de este fichero
// o comentarse. De otra manera habría dos definciones de la misma función
//-----------------------------------------------------------------------------------

/*
 * Ejercicio 3 (a realizar en casa):
 *   Comentad completamente la siguiente funci�n, y sustituidla por la subrutina correspondiente
 *   a codificar en el fichero rutinas_asm.asm
 *
void RGB2GrayMatrix(pixelRGB orig[N][M], unsigned char dest[N][M]) {
    int i,j;
    
    for (i=0;i<N;i++)
        for (j=0; j<M; j++)
            dest[i][j] =  rgb2gray(orig[i][j].R, orig[i][j].G, orig[i][j].B);
    
}
*/

void Gray2BinaryMatrix(unsigned char orig[N][M], unsigned char dest[N][M]) {
    int i,j;
    int umbral = 127;
    
    for (i=0;i<N;i++)
        for (j=0; j<M; j++)
            if (orig[i][j] > umbral)
                dest[i][j]=255;
            else
                 dest[i][j]=0;
    
}

/*
 * Ejercicio 2 (a realizar en casa): comentad COMPLETAMENTE la subrutina rgb2gray en el fichero rutinas_asm.asm
 *   y completad el cuerpo de la siguiente subrutina para que la funcionalidad sea exactamente la misma
 */
int rgb2gray(int R, int G, int B) {
	int coef1 = 3483, coef2 = 11718, coef3 = 1183;
	int resultado;

	resultado = R*coef1 + G*coef2 + B*coef3;
	resultado = resultado/16384;

	return resultado;
}

/*
void contarBlancos(unsigned char mat[N][M], unsigned char vector[N]) {
    int i,j;

    for (i=0;i<N;i++) {
        vector[i]=0;
        for (j=0; j<M; j++) {
            if ( mat[i][j] == 255) vector[i]++;
        }
    }
}*/
