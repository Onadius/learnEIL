/*
//データ変換処理

文字列 -> 数値
atoi(s) : 文字列sをint型に変換して返す
atof(s) : 文字列sをdouble型に変換して返す

数値 -> 文字列
sprintf(格納先, 書式指定文字列, 引数)


//ファイル処理

1.ファイル入出力の流れ
ファイル入出力は以下の手順を踏みます。

(1)ファイル構造体のポインタ作成
               ▼
(2)ファイルオープン
               ▼
(3)ファイルの読み書き
               ▼
(4)ファイルクローズ

ファイルポインタの宣言


ファイル操作を行うためにはファイル情報を示す変数が必要です。
C言語ではファイル情報を格納するFILE型構造体を用意し、
そのポインタ（ファイルポインタ）を利用します。ファイルポインタの宣言は次の通りです。
FILE *変数名;


ファイルのオープンとクローズ

ファイル操作する為には、まず「fopen()」を使用してファイルをオープンし、
取得したファイルポインタでファイルアクセスします。
そしてファイル操作終了後は「fclose()」でファイルポインタを開放して終了です。

ファイルオープン
「fopen()」の書式は次の通りです。
FILE *fopen(const char *filename, const char *mode);

filename：ファイル名
mode：ファイルの取扱い方法

モード(mode)一覧
記号	処理	ファイルが存在するとき	ファイルが存在しないとき
r	読み込み	そのファイルポインタを返します。（カーソル位置は先頭）	エラー（EOFを返します。）
r+	読み込み・書き込み	そのファイルポインタを返します。（カーソル位置は先頭）	エラー（EOFを返します。）
w	書き込み	ファイルを初期化し、そのファイルポインタを返します。	新規作成し、そのファイルポインタを返します。
w+	書き込み・読み込み	ファイルを初期化し、そのファイルポインタを返します。	新規作成し、そのファイルポインタを返します。
a	追加書き込み	そのファイルポインタを返します。（カーソル位置は終端）	新規作成し、そのファイルポインタを返します。
a+	追加書き込み・読み込み	そのファイルポインタを返します。（カーソル位置は終端）	新規作成し、そのファイルポインタを返します。


「fclose()」の書式は次の通りです。
int fclose(FILE *fp);

【引数】
fp：クローズするファイルのファイルポインタ
【戻り値】
成功時：0
失敗時：EOF

fgets()	char *fgets(char *s, int n, FILE *stream);
「*stream」で示されるストリームから「n-1」文字を取得し「\0」を付加して、
その文字列の先頭アドレスを引数のchar型ポインタ（*str）
に渡すと共に戻り値としても返します。

fscanf()	int fscanf(FILE *fp, const char *format, ...);
ファイルポインタ（*fp）で示されるファイルからの入力値を
書式指定した文字列として取得します。
第3引数以降は「const char *format」（書式指定文字列※2）の変換指定子の
数だけ変数を指定します。

---------------------------------------------------------------------------------------------

//ファイル出力

C言語でファイル出力するには主に↓の関数またはマクロを使用します。


関数一覧
fputs()	int fputs(const char *s, FILE *stream);
文字列sをストリームに出力します。

fprintf()	int fprintf(FILE *stream, const char *format,...);
書式指定文字列※2をストリームに出力します。
第2引数以降は出力元となる変数を変換指定子※2の数だけ指定します。

*/
