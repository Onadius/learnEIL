#include <stdio.h>
#include <string.h>

void main(void){
  char a[] = "ABCDEFG" ;
  char b[20] ;
  int i ;


  //変数に文字列を代入する場合には「strcpy関数」を使います
  /*
  strcpy(b, a) ;
  fprintf(stdout, "a[%s] -> b[%s]\n", a, b); //strcpy(b, a)
  */

  for(i=0 ; i<=8 ; i++){
    b[i] = a[i];
  }
  fprintf(stdout, "a[%s] -> b[%s]\n", a, b); //第一引数stdoutは、printf(文字列)と一緒
}



/* -------結果

a[ABCDEFG] -> b[ABCDEFG]

----------- */
