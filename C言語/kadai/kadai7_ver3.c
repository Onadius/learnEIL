/*
参考
https://goo.gl/A7W4aP

ポインタ表記にする
*/

#include<stdio.h>
#include<math.h>

#define YNUM 21
#define XNUM 72
#define PI 3.1415926


/* -- 出力関数 -- */
void plot(int y, int x, int (*g)[XNUM]){
  for ( y = 0 ; y < YNUM ; y++ ){

    for ( x = 0 ; x < XNUM ; x++ ){

      if ( *(g[y] + x) == 1 ){
        putchar('*');
      }
      else{
        putchar(' ');
      }
    }
    putchar('\n');
  }
}


/* -- 初期化関数 -- */
void initialization(int y, int x, int g[][XNUM]){

  for ( y = 0 ; y < YNUM ; y++ ) {

      for ( x = 0 ; x < XNUM ; x++ ) {
        *(g[y] + x) = 0 ;
      }
  }
}


/* -- マーク関数 -- */
void mark_1(int y, int x, int g[][XNUM]) {

  for ( y = 0 ; y < YNUM ; y++ ) {

    for (x = 0 ; x < XNUM ; x++) {

      if (y == (int)((-10) * sin(PI * x / (int)(XNUM/2)) + 10)) {
        *(g[y] + x) = 1 ;
      }
    }
  }
}



/* -- main関数 -- */
int main(void) {
  int    g[YNUM][XNUM]; /*[行 y][列 x]*/
  int    y, x;


  /*二次元配列内全て0に初期化*/
  initialization(y, x, g) ;

  /*プロットするマス(二次元配列)に1をマーク*/
  mark_1(y, x, g) ;

  /*出力処理*/
  plot(y, x, g);
  return 0;
}


/* ------------結果
C:\Users\Administrator\Desktop\text\C言語>miku
             **********
           **          **
         **              **
        *                  *
      **                    **
     *                        *
    *                          *
   *                            *
  *                              *
 *                                **
*                                   *                                *
                                     *                              *
                                      *                            *
                                       *                          *
                                        *                        *
                                         **                    **
                                           *                  *
                                            **              **
                                              **          **
                                                **********
*/
