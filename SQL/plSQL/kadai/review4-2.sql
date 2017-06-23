/*
4.EMP表に存在する人物のSALを全て足して、
RESULTテーブルのNRESULT2にinsertするPLSQLを書きなさい。
このとき、Qより後のアルファベットで始まるJOBの人物のSALは
DEPTNO倍して足しなさい。

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review4-2.sql

バルク処理バージョン

*/


set SERVEROUTPUT on

DECLARE
  sal_sum number := 0;


  /* 複数レコードをまとめて取得する（バルク処理：SELECT～INTO）*/
  type emp_type is table of emp%rowtype ; -- 表「emp」のコレクション型「emp_type」定義
  miku emp_type ; ---- コレクション型「emp_type」の配列定義


BEGIN

  -- 表「emp」から取得した項目を、配列「emp_rec」に代入する
  select * bulk collect into miku from emp;

  for i in 1..miku.count loop
    if substr(miku(i).JOB, 1, 1) >= 'Q' THEN
      sal_sum := sal_sum + (miku(i).sal * miku(i).deptno) ;

    ELSE
      sal_sum := sal_sum + miku(i).sal ;

    END if ;
  END loop ;

  dbms_output.put_line(sal_sum) ;


END ;
/
