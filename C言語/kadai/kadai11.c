/*
環状リストを用いて、
サービス名順にファイル書き込み
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
void Replace(struct services *honnmono, struct services *nisemono) ;
void Unlink(struct services *element) ;
void Link(struct services *NextElem, struct services *LinkElem) ;


/* main関数 */
int main(void){

  char fname[] = "services.txt" ;
  FILE *fp ;
  char str[MOZINUM] ;
  int  ret ;

  /* -- 自己参照構造体定義 -- */
  struct services dmy ;
  struct services *start = &dmy ; //先頭の構造体
  struct services *newdata ; // 最新データ格納用
  struct services *wp ; // 現在位置用
  struct services *nisemono ;
  struct services *honnmono ;

  start->next = NULL ;
  start->before = NULL ;
  wp = start ; //初期化している (1)


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

  /* 双方向循環リスト処理 */
  start->before = wp ;
  wp->next = start ;

  /* ファイル出力 before順に */
  output(wp, start, dmy) ;


  /*------------------ sort関数作成途中 ------------------------*/
  honnmono = wp ;
  nisemono = wp ;

  for( honnmono = start->next ; honnmono != start ; honnmono = honnmono->next ) {
    for(  nisemono = honnmono->next ; nisemono != start ; nisemono = nisemono->next ) {

      ret = strcmp(nisemono->service_name, honnmono->service_name) ;
      //printf("%d\n", ret) ;

      if( ret == -1 ) {
        Replace(honnmono, nisemono) ;
        honnmono = nisemono ;
      }
    }
  }


  printf("We'll rock you!!\n");
  for( honnmono = start ; honnmono->next != start ; honnmono = honnmono->next ) {

    printf("[serviceName] : %s  [portNumber] : %s  [Protocol] : %s\n",
    honnmono->service_name, honnmono->port_number, honnmono->protocol);
  }

  /*------------------------------------------*/
/*
xe: cannot open output file
C:\Users\ADMINI~1\AppData\Local\Temp\kadai11.exe: Permission denied
collect2.exe: error: ld returned 1 exit status
*/

  free(newdata) ;
  fclose(fp) ;
  return 0 ;
}

/*  ------------------------------------------------------------------- */

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


/* ファイル出力関数 */
void output(struct services *wp, struct services *start, struct services dmy) {

  /*出力ファイル用変数*/
  char fname[] = "mikumiku.txt" ;
  FILE *opnfile ;

  if((opnfile = fopen(fname, "w")) == NULL){
    printf("can't open file\n") ;
  }

  /* next順に表示。末尾wp->nextが先頭アドレスstartを指すときloop終了 */
  for( wp = start ; wp->next != start ; wp = wp->next ){

    fprintf(opnfile, "[serviceName] : %s  [portNumber] : %s  [Protocol] : %s\n",
    wp->service_name, wp->port_number, wp->protocol);
  }

  fclose(opnfile) ;
}


/* ---入れ替え関数 --- */
void Replace(struct services *honnmono, struct services *nisemono) {

  struct services *Back ;
  struct services *Next ;

  Back = honnmono->before ;
  Next = nisemono->next ;

  Unlink(honnmono) ;
  Unlink(nisemono) ;

  Link(Back->next, nisemono) ; //Back->nextには何もないよ
  Link(Next, honnmono) ;

}


/* ---- 渡した構造体ポインタの前後つながり消去関数 ---- */
void Unlink(struct services *element) {

  struct services *BackElem ;
  struct services *NextElem ;

  BackElem = element->before ;
  NextElem = element->next ;

  BackElem->next = NextElem ;
  NextElem->before = BackElem ;

  return ;
}


/* --- 連結関数 --- */
void Link(struct services *NextElem, struct services *LinkElem) {
  struct services *PrevElem ;

  PrevElem = NextElem->before ;
  LinkElem->before = PrevElem ;
  LinkElem->next = NextElem ;
  PrevElem->next = LinkElem ;
  NextElem->before = LinkElem ;

  return ;
}


/* -- 結果

[serviceName] :   [portNumber] :   [Protocol] :
[serviceName] : echo  [portNumber] : 7  [Protocol] : tcp
[serviceName] : echo  [portNumber] : 7  [Protocol] : udp
...
[serviceName] : imip-channels  [portNumber] : 11320  [Protocol] : udp
[serviceName] : directplaysrvr  [portNumber] : 47624  [Protocol] : tcp

*/
