/*

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\howtoBulc.sql


�E�o���N�����̎g����
�E%rowtype�g�p���@

*/

-- console ���O�\��
SET SERVEROUTPUT ON


DECLARE

  /* �������R�[�h���܂Ƃ߂Ď擾����i�o���N�����FSELECT�`INTO�j*/
  type emp_type is table of emp%rowtype ; -- �\�uemp�v�̃R���N�V�����^�uemp_type�v��`
  emp_rec emp_type ; ---- �R���N�V�����^�uemp_type�v�̔z���`

BEGIN

  -- �\�uemp�v����擾�������ڂ��A�z��uemp_rec�v�ɑ������
  select * bulk collect into emp_rec from emp;

  for i in 1..emp_rec.count loop
    dbms_output.put_line(emp_rec(i).ename) ;
  end loop ;

END ;
/
