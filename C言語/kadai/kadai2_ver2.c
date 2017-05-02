/*
参考
https://goo.gl/A7W4aP
*/

#include<stdio.h>
#include<math.h>

int main(void) {
  int    g[20][60]; /*[行 y][列 x]*/
  int    y, x;
  double PI =  3.1415926;

  /*
  y(行) = 半径r*sinΘ
  ドラグマ単位のｎ°のラジアン単位変換は ｎ° × PI ÷ １８０
  */

  /*二次元配列内全て0に初期化*/
  for ( y = 0; y < 20; y++ ) {

      for ( x = 0; x < 60; x++ ) {
        g[y][x] = 0;
      }
  }

  /*プロットするマス(二次元配列)に1をマーク*/
  for ( y = 0; y < 20; y++ ) {

    for (x = 0; x < 60; x++) {
      /*
      sin(X) : 1～ -1の範囲をとる
      これでは扱いにくいので-１０倍して１０を足す事で範囲を０～1０に変換
      ex. y=10のとき、x=0の値を取れば、y(10) = 10 でg[10][0]の地点にプロット.
      30は60列(x)の真ん中にあたる

      */
      if (y == (int)((-10) * sin(PI * x / 30) + 10)){
        g[y][x] = 1;
      }
    }
  }


  /*プロット地点の探索*/
  for ( y = 0; y < 20; y++ ){

    for ( x = 0; x < 60; x++ ){
      if ( g[y][x] == 1 ){
        putchar('*');
      }
      else{
        putchar(' ');
      }
    }
    putchar('\n');
  }

  return 0;
}




/* ------------結果
C:\Users\Administrator\Desktop\text\C言語>hello
           *********
         **         **
        *             *
       *               *
      *                 **
    **                    *
   *                       *
  *                         *
 *                           *
                              *
*
                               *                           *
                                *                         *
                                 *                       *
                                  **                    *
                                    *                 **
                                     *               *
                                      *             *
                                       **         **
                                         *********

*/
