/*
@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\��ƈ˗�\txtToTable.sql


DELETE FROM m06
WHERE sn = '16299010500939' ;

testtmp

cpm06

�̍폜

 select * from m06 where sn = '16299010500138' ;
 max249

 DELETE FROM testtmp
 WHERE sn = '16299010500138';
*/
set SERVEROUTPUT on ;

DECLARE

  /* ---
  -- �\�utmp�v�̃R���N�V�����^�utmp_type�v��`
  -- �R���N�V�����^�utmp_type�v�̔z��miku��`
  --- */
  type tmp_type is table of TESTTMP%rowtype ;
  miku tmp_type ;

  modelName   m06.MODEL%TYPE := 'DS4308-HC0020BZZAP' ; --MODEL
  userCord    m06.CUCD%TYPE := '700' ; --CUCD
  dateTime    m06.DAT%TYPE := SYSDATE ; --DAT
  oldSN       m06.OSN%TYPE := '16299010500138' ;
  txtMemo     m06.MEMO%TYPE := 'IT9000�p���' ;

BEGIN

  /* �\�uemp�v����擾�������ڂ��A�z��miku�ɑ������ */
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
 select sn from m06 where memo = 'IT9000�p���' order by cencd ;
 250�s


 SELECT sn
FROM m06
GROUP BY sn HAVING COUNT(sn)<>1 ;

*/
