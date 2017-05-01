/*
修正済み
--1.1～5000までの数字の足算の結果を
--RESULTテーブルのNRESULTにinsertするPLSQLを書きなさい。
*/

SET SERVEROUTPUT ON
DECLARE
  num number := 0;
  miku number := 0;

BEGIN
  LOOP
    miku := miku + num ;
    num := num + 1 ;
    exit when num >= 5001;
  END LOOP ;
  DBMS_OUTPUT.PUT_LINE(miku);

  insert into RESULT
  (NRESULT)
  values
  (miku);
END;
/


NO            NRESULT      CRESULT
---------- ---------- ------------
            12502500




=================================
/* 添削 */

/* ★PLSQLの解答は１つではなく、コレが正解というものはありません。★ */
/* ★が、こうしたほうが良いというアドバイスという意味で修正案だけ提示します。★ */

DECLARE
  num  number := 0;						/* 変数"num"の型はnumber型でいい。一連の処理でEMPテーブルは使用しないため。 */
  miku number := 0;

BEGIN
  LOOP
    miku := miku + num ;
    num := num + 1 ;
    exit when num >= 5001;				/* exitは先頭よりも、一連の処理の最後にあったほうがわかりやすいです。 */
  END LOOP ;
  DBMS_OUTPUT.PUT_LINE(miku);

  insert into RESULT 					/* インデントはこっちのほうが見やすいかな…これは個人趣味。 */
	(NRESULT)
  values
	(miku);
END;
/


=================================
/* 解答例 forループだけど。 */


21:48:16 SQL>
21:48:16 SQL>
21:48:16 SQL> declare
21:48:16   2   w_ret number(12) := 0;
21:48:16   3  begin
21:48:16   4   for i in 1..5000 loop
21:48:16   5    w_ret := w_ret + i;
21:48:16   6   end loop;
21:48:16   7   dbms_output.put_line(w_ret);
21:48:16   8
21:48:16   9   insert into result (nresult) values (w_ret);
21:48:17  10  end;
21:48:17  11  /
12502500

PL/SQLプロシージャが正常に完了しました。

経過: 00:00:00.04
21:48:17 SQL>
21:48:17 SQL> select * from result;

             NO         NRESULT CRESULT                                  JNRESULT
--------------- --------------- ---------------------------------------- ---------------------------
@                      12502500 @                                        @

経過: 00:00:00.01
21:48:25 SQL>
