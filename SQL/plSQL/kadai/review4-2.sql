/*
4.EMP�\�ɑ��݂���l����SAL��S�đ����āA
RESULT�e�[�u����NRESULT2��insert����PLSQL�������Ȃ����B
���̂Ƃ��AQ����̃A���t�@�x�b�g�Ŏn�܂�JOB�̐l����SAL��
DEPTNO�{���đ����Ȃ����B

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review4-2.sql

�o���N�����o�[�W����

*/


set SERVEROUTPUT on

DECLARE
  sal_sum number := 0;


  /* �������R�[�h���܂Ƃ߂Ď擾����i�o���N�����FSELECT�`INTO�j*/
  type emp_type is table of emp%rowtype ; -- �\�uemp�v�̃R���N�V�����^�uemp_type�v��`
  miku emp_type ; ---- �R���N�V�����^�uemp_type�v�̔z���`


BEGIN

  -- �\�uemp�v����擾�������ڂ��A�z��uemp_rec�v�ɑ������
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
