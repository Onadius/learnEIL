/*
修正済み
2.一番小さいEMPNOの人のSALが1000以上だったら
RESULTテーブルのCRESULTに'TRUE',
1000未満だったら'FALSE'をinsertするPLSQLを書きなさい。

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review2_2.sql

・IF分岐
・INSERT処理

*/

-- console ログ表示
SET SERVEROUTPUT ON

DECLARE
  sal_min number := 0 ;
  uduki VARCHAR2(30) ; --初期化した方がええんやろか

  /* 複数レコードをまとめて取得する（バルク処理：SELECT～INTO）*/
  type emp_type is table of emp%rowtype ; -- 表「emp」のコレクション型「emp_type」定義
  miku emp_type ; ---- コレクション型「emp_type」の配列定義

BEGIN
  -- 表「emp」から取得した項目を、配列mikuに代入する
  select * bulk collect
  into miku
  from emp
  order by sal ;

  dbms_output.put_line(miku(1).sal) ;

  --文字列格納判別処理
  if miku(1).sal > 1000 then
    uduki := 'Get Smile!!' ;

  else
    uduki := 'Lost Smile...' ;

  END if ;

  -- 判定文字列Insert処理
  INSERT into RESULT
    (CRESULT)
  values
    (uduki) ;

  dbms_output.put_line(uduki) ;
END ;
/
