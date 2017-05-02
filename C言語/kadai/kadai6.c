/*ポインタ表記で書き換え*/

#include <stdio.h>
#include <string.h>

void main(void){
  char a[] = "ABCDEFG" ;
  char *b = a ;
  int i ;

  int ln = strlen(a) ;

  for(i=0 ; i<=ln ; i++){
    if(a[i] == "\0") {
      break ;
    }else{
      *(b + i) = a[i];
    }
  }
  fprintf(stdout, "a[%s] -> b[%s]\n", a, b); //第一引数stdoutは、printf(文字列)と一緒
}


/*

結果
a[ABCDEFG] -> b[ABCDEFG]

*/
