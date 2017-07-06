/*
@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\作業依頼\txtToTable.sql


DELETE FROM m06
WHERE sn = '16299010500939' ;

testtmp

cpm06

の削除

 select * from m06 where sn = '16299010500138' ;
 max249

 DELETE FROM testtmp
 WHERE sn = '16299010500138';
*/
set SERVEROUTPUT on ;

DECLARE

  /* ---
  -- 表「tmp」のコレクション型「tmp_type」定義
  -- コレクション型「tmp_type」の配列miku定義
  --- */
  type tmp_type is table of TESTTMP%rowtype ;
  miku tmp_type ;

  modelName   m06.MODEL%TYPE := 'DS4308-HC0020BZZAP' ; --MODEL
  userCord    m06.CUCD%TYPE := '700' ; --CUCD
  dateTime    m06.DAT%TYPE := SYSDATE ; --DAT
  oldSN       m06.OSN%TYPE := '16299010500138' ;
  txtMemo     m06.MEMO%TYPE := 'IT9000用ｺﾌﾞ' ;

BEGIN

  /* 表「emp」から取得した項目を、配列mikuに代入する */
  select * bulk collect into miku from testtmp order by CENCD ;

  for i in 231..249 loop
    dbms_output.put_line(miku(i).SN) ;
    INSERT into m06 (SN, MODEL, CUCD, CENCD, DAT, OSN, MEMO)
    values
      (miku(i).SN, modelName, userCord, miku(i).CENCD, dateTime, oldSN, txtMemo) ;

  END loop ;

END ;
/


/*
 select sn from m06 where memo = 'IT9000用ｺﾌﾞ' order by cencd ;
 250行


 SELECT sn
FROM m06
GROUP BY sn HAVING COUNT(sn)<>1 ;

*/
