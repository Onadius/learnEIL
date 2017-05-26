/*
proc kadai 1
(1)
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "kadai.h"

/* str of DB connect */
#define USERANDPASS "ohki/ryutu@yodadb.world"

/* Oracle error cord reading */
EXEC SQL INCLUDE SQLCA ;

int Logon ;

/* prototype decrare of function */
int LoginToOracle() ;
int MainProcedure() ;
int Terminate(int extcd) ;
int LogoutFromOracle(int extcd) ;




/* ------------ main function ------------ */
int main(void) {

  int extcd = 0 ;

  /* oracle login function */
  LoginToOracle() ;

  /* main processing */
  while ( ((extcd = MainProcedure()) >= 0) ) {

  }

  /* fin processing */
  Terminate(extcd) ;

  /* pro*C fin */
  exit(extcd) ;
}



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
    VARCHAR cucd[7 + 1] ;
    VARCHAR cuscd[3 + 1] ;
    VARCHAR sp_tennpo_cord[10] ;
    VARCHAR formal_name[50] ;
    VARCHAR address[51] ;
    VARCHAR tel_num[20] ;
    VARCHAR send_corse[10] ;
  EXEC SQL END   DECLARE SECTION ;

  /* C variable decrare */


  /* Decreare cursor */
  EXEC SQL DECLARE CUR1 CURSOR FOR
    select * from AFM032 ;
  if( V_SQLCODE) {

    printf("Decrare cursor error dayo Master !!\n") ;
    return (-2) ;
  }

  /* Open cursor */
  EXEC SQL OPEN CUR1 ;
  if( V_SQLCODE) {

    printf("Open cursor error dayo Master !!\n") ;
    return (-2) ;
  }



  EXEC SQL CLOSE CUR1 ;
  if( V_SQLCODE ) {

    printf("Fetch error dayo Master !!\n") ;
    return (-1) ;
  }

  return (0) ;
}


/* -- fin processing -- */
int Terminate(int extcd) {

  LogoutFromOracle(extcd) ;
  printf("See you again, My master !!\n") ;

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
