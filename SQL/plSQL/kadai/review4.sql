/*
4.EMP�\�ɑ��݂���l����SAL��S�đ����āA
RESULT�e�[�u����NRESULT2��insert����PLSQL�������Ȃ����B
���̂Ƃ��AQ����̃A���t�@�x�b�g�Ŏn�܂�JOB�̐l����SAL��
DEPTNO�{���đ����Ȃ����B

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review4.sql



*/


set SERVEROUTPUT on

DECLARE
  money1 number ;
  money2 number ;

BEGIN
  select SUM( NVL(E.SAL, 0) * E.deptno )
  into money1
  from emp E
  where substr(E.job, 1, 1) >= 'Q' ;

  select SUM( NVL(E.sal, 0) )
  into money2
  from emp E
  where substr(E.job, 1, 1) < 'Q' ;

  dbms_output.put_line(money1 + money2) ;

  insert into RESULT
    (NRESULT2)
  values
    (money1 + money2) ;
    
END ;
/
