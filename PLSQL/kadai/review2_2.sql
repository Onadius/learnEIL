/*
�C���ς�
2.��ԏ�����EMPNO�̐l��SAL��1000�ȏゾ������
RESULT�e�[�u����CRESULT��'TRUE',
1000������������'FALSE'��insert����PLSQL�������Ȃ����B

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review2_2.sql

�EIF����
�EINSERT����

*/

-- console ���O�\��
SET SERVEROUTPUT ON

DECLARE
  sal_min number := 0 ;
  uduki VARCHAR2(30) ; --���������������������납

  /* �������R�[�h���܂Ƃ߂Ď擾����i�o���N�����FSELECT�`INTO�j*/
  type emp_type is table of emp%rowtype ; -- �\�uemp�v�̃R���N�V�����^�uemp_type�v��`
  miku emp_type ; ---- �R���N�V�����^�uemp_type�v�̔z���`

BEGIN
  -- �\�uemp�v����擾�������ڂ��A�z��miku�ɑ������
  select * bulk collect
  into miku
  from emp
  order by sal ;

  dbms_output.put_line(miku(1).sal) ;

  --������i�[���ʏ���
  if miku(1).sal > 1000 then
    uduki := 'Get Smile!!' ;

  else
    uduki := 'Lost Smile...' ;

  END if ;

  -- ���蕶����Insert����
  INSERT into RESULT
    (CRESULT)
  values
    (uduki) ;

  dbms_output.put_line(uduki) ;
END ;
/
