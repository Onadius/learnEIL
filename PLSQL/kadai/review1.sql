/*
1.1�`5000�܂ł̐����̑��Z�̌��ʂ�
RESULT�e�[�u����NRESULT��insert����PLSQL�������Ȃ����B

�t�@�C�����sfull�p�X
@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\

�EFOR loop����

*/

-- console ���O�\��
SET SERVEROUTPUT ON

DECLARE
  miku NUMBER := 0 ;

BEGIN
  for i in 1..3939 LOOP
    --dbms_output.put_line('loop�� : ' || i) ;
    miku := miku + i ;
  END LOOP ;

  insert into RESULT
    (NRESULT)
  values
    (miku) ;

  dbms_output.put_line(miku) ;

END ;
/
