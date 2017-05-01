//メモリ管理

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (){

  char* sp[10] ;
  char buf[80] ;
  int  i, n ;

  n = 0 ;
  while ( gets(buf) != NULL) { /* ctrl + z まで文字列入力 */

    /* メモリ確保 */
    sp[n] = (char*)malloc(strlen(buf) + 1) ; /* char型のポインタにキャスト。入力した文字数+1バイト確保*/
    if (sp[n] == NULL) {
      printf("メモリ確保不可\n");
      exit(1) ;
    }

    strcpy(sp[n], buf) ; /*sp[n]に入力文字列代入*/
    n++ ;

  }

  for(i = 0 ; i < n ; i++) {
    printf("%d : %s\n", i, sp[i]) ;

    /*処理終了後のメモリ解放*/
    free(sp[i]) ;
  }
}

/*
エロマンガ先生
さぎりちゃん
^Z
0 : エロマンガ先生
1 : さぎりちゃん
*/
