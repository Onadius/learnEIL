#include <stdio.h>
#include <string.h>

/*構造体型枠宣言*/
struct seiseki {
  int no ;
  char name[20] ;
  double average ;
  char koibito[20] ;
} ;


int main(void) {

  int i ;

  /* 構造体の初期化と宣言 */
  struct seiseki miku ;
  struct seiseki *rin ;
  rin = &miku ;

  strcpy((*rin).name, "RIN") ;
  (*rin).no = 39 ;
  (*rin).average = 39.3 ;

  //アロー演算子
  strcpy(rin->koibito, "Shota") ;


  /* 構造体の参照 */
  printf("No : %d\nName : %s\nAve : %.1f\nkoibito: %s\n",
    rin->no, rin->name, rin->average, rin->koibito) ;
}

/*
//構造体scheduleの全メンバを表示する
void printSchedule(struct schedule data) {
    printf("%04d/%02d/%02d %02d:00 %s\n",
           data.year, data.month, data.day, data.hour, data.title);
}

*/
