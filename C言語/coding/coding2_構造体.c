//構造体の利用

/* -----cording1
#include <stdio.h>

//構造体の宣言
struct student{
  char name[20] ;
  int kokugo ;
  int sansuu ;
} ;


int main(void) {
  struct student seito ; //変数seitoを宣言
  strcpy(seito.name, "hatsune miku") ;
  seito.kokugo = 39;
  seito.sansuu = 39;

  printf("name : %s\nkokugo : %d\nsansu : %d", seito.name, seito.kokugo, seito.sansuu);

  return 0 ;
}
*/


/*
//アロー演算子の利用
#include <stdio.h>

struct student{
  char name[20] ;
  int kokugo ;
  int sansuu ;
} ;


int main(void) {
  struct student seito ; //変数seitoを宣言
  struct student *sp = &seito ;

  strcpy(sp->name, "Kagamine Rin") ;
  sp->kokugo = 39 ;
  (*sp).sansuu = 39 ;

  printf("name : %s\nkokugo : %d\nsansu : %d", seito.name, seito.kokugo, seito.sansuu);

  return 0 ;
}
*/



//構造体を関数に渡す
#include <stdio.h>

struct student{
  char name[20] ;
  int kokugo ;
  int sansuu ;
} ;

void seidisp1(struct student sei); //関数プロトタイプ宣言(memo4.c参照)超絶便利
void seidisp2(struct student *sei);

int main(void) {
  struct student seito = {"Hatsune Miku", 39, 39} ; //変数seitoを宣言、初期化

  seidisp1(seito) ; //値渡し
  seidisp2(&seito) ;

  return 0 ;
}



void seidisp1(struct student sei) { //仮引数は構造体student型
  printf("%s  %d   %d\n", sei.name, sei.kokugo, sei.sansuu);
}


void seidisp2(struct student *sei){ //仮引数は構造体studentを指すポインタ
  printf("%s  %d   %d\n", sei->name, sei->kokugo, sei->sansuu);
}
