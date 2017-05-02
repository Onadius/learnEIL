/*
参考
https://goo.gl/A7W4aP

ポインタ表記にする
*/



#include<stdio.h>
#include<math.h>

#define ynum 21
#define xnum 72


void plot(int y, int x, int (*g)[xnum]){
  for ( y = 0; y < ynum; y++ ){

    for ( x = 0; x < xnum; x++ ){
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


int main(void) {
  int    g[ynum][xnum]; /*[行 y][列 x]*/
  int    y, x;
  double PI =  3.1415926;


  /*二次元配列内全て0に初期化*/
  for ( y = 0; y < ynum; y++ ) {

      for ( x = 0; x < xnum; x++ ) {
        *(g[y] + x) = 0 ;
      }
  }

  /*プロットするマス(二次元配列)に1をマーク*/
  for ( y = 0; y < ynum; y++ ) {

    for (x = 0; x < xnum; x++) {

      if (y == (int)((-10) * sin(PI * x / (int)(xnum/2)) + 10)){
        *(g[y] + x) = 1 ;
      }
    }
  }
  plot(y, x, g); //二次元配列を渡す(ポインタ使用)
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
