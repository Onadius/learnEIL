/*
--3.��ԑ���JOB�̖��O��RESULT�e�[�u����JNRESULT��insert����PLSQL�������Ȃ����B
--@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai.sql

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review3.sql

�Ecursor�錾�Ƃ��̎g����
�Efor�ł̃J�[�\���̒��g�̎��o��

*/


set SERVEROUTPUT on
DECLARE
  cursor mikumiku is
    select job
    from emp E
    group by E.job
    having
      count(E.job) = (
        select MAX(count(A.job))
        from emp A
        group by A.job
      ) ;

BEGIN
  for miku_rec in mikumiku loop
    insert into RESULT
      (JNRESULT)
    values
      (miku_rec.job) ;
  END loop ;

END ;
/

select * from result ;
