/*
�C���ς�
2.��ԏ�����EMPNO�̐l��SAL��1000�ȏゾ������
RESULT�e�[�u����CRESULT��'TRUE',
1000������������'FALSE'��insert����PLSQL�������Ȃ����B

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review2.sql

�EIF����
�EINSERT����

*/

-- console ���O�\��
SET SERVEROUTPUT ON

DECLARE
  min_sal NUMBER := 0 ;
  eromannga VARCHAR2(30) ;  

BEGIN
  select E.sal into min_sal
  from emp E
  where
    empno = (
      select MIN(A.empno)
      from emp A
    ) ;

  if (min_sal >= 1000 ) THEN
    eromannga := '�і������' ;

  else
    eromannga := '����Ȗ��O�̐l�͒m��Ȃ�' ;

  END if ;

  INSERT into result
    (CRESULT)
  values
    (eromannga) ;

  dbms_output.put_line('���Z�����̃��m�x��l��!!') ;

/*
EXCEPTION
  when others then
  dbms_output.put_line('�G���[�����I�I');
  */


END ;
/
