/* --------------------------
�E�g�p��������e�[�u���̃R�s�[�ym04, m06�z
  create table cpm04 as select * from m04 ;
  create table cpym06 as select * from m06 ;

sqlplus emori/emori

select
  cucd, cencd, cennm
from
  m04
where
  cucd = '700'
order by cucd,cencd ;


CUCD   CENCD  CENNM
------ ------ ------------------------------------------------------------
700    000    �g�t�a
700    001    �Ǘ��{���@�V�X�e����
700    002    �k�������Z���^�[
700    003    �Ǘ��{���@������
700    004    �_�˔z���Z���^�[
700    005    ���R�z���Z���^�[
700    006    ���k�����Z���^�[
700    010    ���������Z���^�[
700    570    �֐������Z���^�[
700    590    ��B�����Z���^�[
700    600    �l���z���Z���^�[
700    999    �O��Z�R��SC�Z���^�[

(1)��`�I���ɂ��tmp�e�[�u���쐬, CENCD(varchar2(3)), SN(not null, varchar2(20))

(2)m04�̃e�[�u���Q�l�ɁA�Ή����鋒�_�ԍ�(CENCD)����
  tmp���o���N�����ɂĊi�[�����V���A�����Am06�̃e�[�u���ɃC���T�[�g����




-------------------------- */


CREATE TABLE TESTTMP (
  CENCD VARCHAR2(3) ,
  SN VARCHAR2(20) NOT NULL
);

drop table cpm06 ;
