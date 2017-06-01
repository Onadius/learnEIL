/*
proc kadai 1 (2)
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "kadai.h"

/* prototype decrare of function */
int GetArgument() ;
int LoginToOracle() ;
int MainProcedure() ;
int Terminate() ;
int LogoutFromOracle() ;

/* str of DB connect */
#define USERANDPASS "ohki/ryutu@yodadb.world"

/* Oracle error cord reading */
EXEC SQL INCLUDE SQLCA ;

/* global variable DECLARE */
int Logon ;
int  giMode = 0 ;
char gsCucd[7+1] ;
char gsCuscd[3+1] ;


/* ---------- oracle login function ---------- */
int LoginToOracle() {

  EXEC SQl BEGIN DECLARE SECTION ;
    VARCHAR UserAndPass[70] ;
  EXEC SQL END DECLARE SECTION ;

  memset(UserAndPass.arr, 0, sizeof((char*)UserAndPass.arr)) ;
  strcpy((char*)UserAndPass.arr, USERANDPASS);
  UserAndPass.len = strlen( (char*)UserAndPass.arr );

  /* loop eror reserch */
  EXEC SQL WHENEVER SQLERROR CONTINUE ;

  /* DB connect */
  EXEC SQL CONNECT :UserAndPass ;
  if ( V_SQLCODE ) {

    printf("Connect Error dayo Master !\n") ;
    return (-1) ;
  }

  Logon = 1 ;
  printf("SUCCESS dayo Master !!\n") ;

  return (0) ;
}



/* ---------- main processing function ---------- */
int MainProcedure() {

  /* host variable decrare */
  EXEC SQL BEGIN DECLARE SECTION ;
    VARCHAR cu_cd[7 + 1] ;
    VARCHAR cus_cd[3 + 1] ;
    VARCHAR cusp_cd[8 + 1] ;
    VARCHAR sp_nm[42 + 1] ;
    VARCHAR sp_ad[42 + 1] ;
    VARCHAR sp_tel[14 + 1] ;
    VARCHAR exp[3 + 1] ;
    VARCHAR sqlstmt[2048+1];
  EXEC SQL END   DECLARE SECTION ;

  /* C variable decrare */
  char wrk[256];
  char *fname = "mikumiku3.txt" ;
  FILE *opnfile ;

  memset(wrk, 0, sizeof(wrk));
  if (giMode == 2 || giMode == 3 || giMode == 4) {
    printf(wrk ," and a.cuscd = '%s'", gsCuscd);
  }

  /* when -C or -T  */
  if (giMode == 1 || giMode == 2) {
    memset((char*)sqlstmt.arr, 0, sizeof((char*)sqlstmt.arr));
    sprintf((char*)sqlstmt.arr,"\
      select CUCD, CUSCD, NVL(CUSPCD,' '), NVL(SPNM,' '), NVL(SPAD1, ' '), NVL(SPTEL, ' '), NVL(EXP, ' ')\
      from afm032 a\
      where a.cucd='%s' %s\
      ORDER BY EXP, CUCD, CUSCD", gsCucd, wrk);

    sqlstmt.len = strlen( (char*)sqlstmt.arr );
    sqlstmt.arr[sqlstmt.len] = '\0';

    EXEC SQL PREPARE miku FROM :sqlstmt;
    if ( V_SQLCODE ) {
      printf("PREPARE Cursor Error\n");
      return( -2 );
    }

    /* DECLARE cursor CUR1 */
    EXEC SQL DECLARE CUR1 CURSOR FOR miku ;
    if ( V_SQLCODE ) {

      printf("Declare Cursor Error\n");
      return( -2 );
    }

    /* open cursor CUR1 */
    EXEC SQL OPEN CUR1;
    if ( V_SQLCODE ) {

      printf("Open Cursor Error\n");
      return( -2 );
    }


    /* open file pointa */
    if((opnfile = fopen(fname, "a+")) == NULL){
      printf("can't open file\n") ;
    }


    /* fetch data */
    for( ; V_SQLCODE != NOTFOUND ; ) {

      /* initialize host variable */
      VarcharInit(cu_cd) ;
      VarcharInit(cus_cd) ;
      VarcharInit(cusp_cd) ;
      VarcharInit(sp_nm) ;
      VarcharInit(sp_ad) ;
      VarcharInit(sp_tel) ;
      VarcharInit(exp) ;

      /* doing fetch */
      EXEC SQL FETCH CUR1 INTO:cu_cd, :cus_cd, :cusp_cd, :sp_nm, :sp_ad, :sp_tel, :exp ;
      if ( V_SQLCODE && (V_SQLCODE != NOTFOUND) ) {

        printf("Fetch error\n");
        /* cursor close when happened error */
        EXEC SQL CLOSE CUR1 ;
        return( -1 );
      }

      /* add "\0" of varchar  */
      VarcharNullAdd(cu_cd) ;
      VarcharNullAdd(cus_cd) ;
      VarcharNullAdd(cusp_cd) ;
      VarcharNullAdd(sp_nm) ;
      VarcharNullAdd(sp_ad) ;
      VarcharNullAdd(sp_tel) ;
      VarcharNullAdd(exp) ;

      /* -- output file -- */
      fprintf(opnfile, "%s  %s  %s  %s  %s  %s  %s\n",
        cu_cd.arr, cus_cd.arr, cusp_cd.arr, sp_nm.arr, sp_ad.arr,
        sp_tel.arr, exp.arr);

    }

    /* cursor close */
    EXEC SQL CLOSE CUR1 ;
    if ( V_SQLCODE ) {

      printf("Fetch error dayo master !!!\n");
      return( -1 );
    }

    /* file po close */
    fclose(opnfile) ;
  }

  return (0) ;
}



/* -- Logout from Oracle function -- */
int LogoutFromOracle(int extcd) {

  if( Logon == 0 ) {
    return (0) ;
  }

  EXEC SQL ROLLBACK WORK RELEASE;
  if ( V_SQLCODE ) {

    printf("Disconnect Error\n");
    return( -1 );
  }

  printf("Logout sitayo Oracle\n");
  Logon = 0;

  return( 0 );
}

/* -- fin processing -- */
int Terminate(int extcd) {

  LogoutFromOracle(extcd) ;
  printf("See you again, My master !!\n") ;

  return (0) ;
}


/* -- arg function  -- */
int      GetArgument(int argc, char** argv)
{
int      i;
char     wrk[24];

  for ( i = 1; i < argc; i++ ) {
    if (*(argv[i]) == '-') {
      switch( toupper(*(argv[i] + 1)) ) {

       case 'C' :
        memset(wrk, 0, sizeof(wrk));
        strcpy(wrk, (argv[i] + 2));
        sprintf(gsCucd, "%s", wrk);
        giMode = 1;
        break;

       case 'T' :
        memset(wrk, 0, sizeof(wrk));
        strcpy(wrk, (argv[i] + 2));
        sprintf(gsCuscd, "%s", wrk);
        giMode = 2;
        break;

       case 'I' :
        giMode = 3;
        break;

       case 'D' :
        giMode = 4;
        break;

       default  :
        ;
      }
    }
    else {

      printf(" It is first error. \n") ;
    }
  }

  return( 0 );
}


/* ------------ main function ------------ */
int main(int argc, char *argv[]) {

  int extcd = 0 ;

  /* get Arg */
  if ( GetArgument(argc, argv) ) {
    exit( extcd );
  }

  /* oracle login function */
  LoginToOracle() ;

  /* main processing */
  MainProcedure() ;


  /* fin processing */
  Terminate(extcd) ;

  /* pro*C fin */
  exit(extcd) ;
}
