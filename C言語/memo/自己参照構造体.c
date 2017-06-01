/*
自己参照型構造体
https://goo.gl/sPQxsr
線形リスト組む時に必須

これは、名前と年齢からなるシンプルな構造体ですが、
最後に自分自身のpersonal構造体をメンバーとして持っています。

struct person{
char name[30];
int age;
struct person *next;
};

最後のメンバー　struct person *next; はpersonal構造体へのポインタです
（すなわちpersonal構造体の先頭アドレス）。

従って、nextに次のpersonal構造体のポインタを代入していくことで、
構造体を次々につなげていくことができるわけです。

宮脇
(*nextに、次にチェーンさせたい構造体のアドレスを
代入できれば、構造体どうしをつなげられる)


次にこの自己参照構造体がどんな時に役にたつのかを簡単に説明いたします。
自己参照構造体では、上の図表のように構造体を次々とつなげて
チェーンを作れるところに特徴があります。
後で説明しますが、このチェーンのつながり（すなわち next にセットするポインタ）
を変更することで、チェーンの順番の入れ替えや削除、追加が柔軟にできます。



（１）基本例
自己参照構造体を使って実際にプログラムを作ったのが以下
まずは、名前と年齢を順次登録し、登録した順に表示するプログラムです。
personal構造体変数として、４つの変数を使っています。
・dmyは初期化用です。
・startは最初のpersonal構造体ですが、このプログラムでは
startのデータはstart->nextだけで、name,ageは空です。
・wpは作業用です。
・wkdataは最新のデータ用です。

*/



#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct person {
  char name[30] ;
  int age ;
  struct person *next ;
} ;

int main(void) {
  struct person dmy;
  struct person *start = &dmy ; //startは最初のpersonal構造体
  struct person *wkdata ; //wkdataは最新のデータ用です。
  struct person *wp ; //wpは作業用です。

  char name[30]=" ",buf[10];
  int tosi;

  start=&dmy;
  start->next=NULL;
  wp=start;

  while(1){ //無限ループ
    printf("name:");
    gets(name);

    if(strcmp(name,"")==0) break;

    printf("age:");
    gets(buf);
    tosi = atoi(buf);

    /*
    ① wkdata=(struct person *)malloc(sizeof(struct person));
    mallocで次のデータに必要な領域を確保します。変数名wkdata*/
    wkdata = (struct person *)malloc(sizeof(struct person));

    /*wkdataというpersonal構造体に名前、年齢を代入します*/
    strcpy(wkdata->name, name);
    wkdata->age=tosi;

    /*wkdata->next をNULLにします。NULLは最後のデータの印とします。*/
    wkdata->next = NULL;

    /*wpはwkdataよりひとつ前のpersonal構造体変数なので、
    ひとつ前のnextにwkdataを設定し、チェーンを作る。*/
    wp->next = wkdata;

    /*wpの指し示すポインタをwkdataにする。
    すなわちwpを最新のpersonal構造体を指し示すようにする。*/
    wp = wkdata;
  }

  //表示
  for(wp = start->next; wp != NULL; wp = wp->next){
    printf("%s %d\n", wp->name, wp->age);
  }

return 0;
}



/*
① wkdata=(struct person *)malloc(sizeof(struct person));
mallocで次のデータに必要な領域を確保します。変数名wkdata







*/
