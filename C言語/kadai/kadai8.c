
/*
servicesを読み込み、以下の各項目を持つ構造体に
格納、表示せよ
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* 構造体宣言 */
struct eromannga {
  char service_name[20] ;
  int port_no ;
  char protocol[10] ;
} ;

#define N 256


int main(void){

  char fname[] = "services" ;
  FILE *fp = NULL ;
  char str[N] ;
  char readline[N] = {'\0'} ;
  char p, q ;

  /*メモリ確保*/
  fp = (FILE*)malloc(1000) ;

  /*ファイルオープン*/
  if(( fp = fopen(fname, "r")) == NULL ) {
    printf("そんな名前の人は知らない\n") ;
  }


  while( fgets(str, sizeof(str), fp) != EOF ) {
    printf("%s", str) ;

  }


  fclose(fp) ;
  free(fp) ;

  return 0 ;
}
