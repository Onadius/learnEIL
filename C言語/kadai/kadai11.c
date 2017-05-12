/*
自己参照構造体として定義しなおし、
線形リストにて格納、表示を行え
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOZINUM 256

/* 構造体宣言 */
struct services {
  char service_name[20] ;
  char port_number[10] ;
  char protocol[20] ;
  struct services *next ;
  struct services *before ;
} ;


/* 関数プロトタイプ宣言 */
void extructStr(char *str, struct services *newdata) ;
void output(struct services *wp, struct services *start, struct services dmy) ;


/* main関数 */
int main(void){

  char fname[] = "services.txt" ;
  FILE *fp ;
  char str[MOZINUM] ;

  /* -- 自己参照構造体定義 -- */
  struct services dmy ;
  struct services *start = &dmy ; //先頭の構造体
  struct services *newdata ; // 最新データ格納用
  struct services *wp ; // 現在位置用

  start->next = NULL ;
  start->before = NULL ;
  wp = start; //初期化している (1)


  /* -- ファイルオープン -- */
  if((fp = fopen(fname, "r")) == NULL){
    printf("can't open file\n") ;
  }

  /* -- ファイル読み込みと格納 -- */
  while( fgets(str, MOZINUM, fp) != NULL ){

    /* 先頭10行を除く処理 */
    if( strncmp(str, "#", 1) == 0 || strcmp(str, "\n") == 0 ) {
      continue ;
    }


    /* 領域確保 */
    newdata = (struct services *)malloc(sizeof(struct services));

    if (newdata == NULL){
      printf("sonnna namae no hito siranai !\n") ;
      break ;
    }


    /* 文字列抽出関数呼び出し */
    extructStr(str, newdata) ;
    newdata->before = wp ;

    if( wp->next == NULL ) {

      /* newdata->next をNULLにする。NULLは最後のデータの印 */
      newdata->next = NULL ;

      /* wpはnewdataよりひとつ前のpersonal構造体変数。
      ひとつ前のnextにnewdataを設定し、チェーンを作る */
      wp->next = newdata ;

      /* wpを最新のpersonal構造体を指し示すようにする (1) */
      wp = newdata ;
    }

  }

  /* 双方向循環リスト処理  */
  start->before = wp ;
  wp->next = start ;


  /* 出力 before順に */
  output(wp, start, dmy) ;

  free(newdata) ;
  fclose(fp) ;
  return 0 ;
}


/* 文字列抽出及び構造体配列への格納関数 */
void extructStr(char *str, struct services *newdata) {

  char *s1, *s2, *s3 ;

  s1 = strtok(str, " /") ;
  strcpy(newdata->service_name, s1) ;

  str = strtok(NULL, " /") ;
  s2 = str ;
  strcpy(newdata->port_number, s2);

  str = strtok(NULL, " /") ;
  s3 = str ;
  strcpy(newdata->protocol, s3);

}


/* 出力関数 */
void output(struct services *wp, struct services *start, struct services dmy) {

  /* next順に表示。末尾wp->nextが先頭アドレスstartを指すときloop終了 */
  for( wp = start ; wp->next != start ; wp = wp->next ){

    printf("[serviceName] : %s  [portNumber] : %s  [Protocol] : %s\n",
    wp->service_name, wp->port_number, wp->protocol);
  }
}



/* -- 結果

[serviceName] :   [portNumber] :   [Protocol] :
[serviceName] : echo  [portNumber] : 7  [Protocol] : tcp
[serviceName] : echo  [portNumber] : 7  [Protocol] : udp
...
[serviceName] : imip-channels  [portNumber] : 11320  [Protocol] : udp
[serviceName] : directplaysrvr  [portNumber] : 47624  [Protocol] : tcp

*/
