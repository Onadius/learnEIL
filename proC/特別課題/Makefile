#========================================================================#
# Makefile :                                                             #
#                                                                        #
#         Pro*C Version 9.0.1.0.0(ML 2.0)                                #
#                                                                        #
#========================================================================#
# ALL RIGHT RESERVED. COPYRIGHT(C) 2001, T.Shirsaki SE-No.229            #
#========================================================================#
default:install

include $(ORACLE_HOME)/precomp/lib/env_precomp.mk

.SUFFIXES: .pc .c .o

SQLPUBLIC=-I$(ORACLE_HOME)/precomp/public

CC       =gcc
AR       =ar
LD       =gcc

MAKEFILE=Makefile

# for Pro*C
USERID   =ohki/ryutu@ohkidb.world
PROC     =$(BINHOME)proc
PROLIBDIR=$(LIBHOME)
PROLIBS  =$(PROLDLIBS)


# for AP
APINCDIR =../../include
APLIBDIR =../../lib
APLIBS   =-lsap -lscom

I_SYM=include=
INCLUDE=$(I_SYM). $(I_SYM)$(APINCDIR)

PCFLAGS  =sqlcheck=full userid=$(USERID) ireclen=150 oreclen=150 parse=none lines=yes nls_local=yes
#PCFLAGS  =sqlcheck=full userid=$(USERID) ireclen=150 oreclen=150 parse=none lines=yes dbms=v7 unsafe_null=yes nls_local=yes

CFLAGS   =-I. -I$(APINCDIR) $(SQLPUBLIC) -g -ansi -D_HIUX_SOURCE -c -DLINUX -D_GNU_SOURCE -D__DELPHI__

#LDFLAGS  =-Wl,-aarchive -L$(APLIBDIR) -L$(PROLIBDIR) -o
LDFLAGS  =-L$(APLIBDIR) -L$(PROLIBDIR) -o

#=============================================================================#
# PROJ    =<load module name>                                                 #
# PSRC    =<Pro*C source file name>                                           #
# CSRC    =<C Language source file name>                                      #
# LINC    =<include file directry>                                            #
#=============================================================================#
PROJ    =spmiku
PSRC    =spkadai.pc
CSRC    =readtxt.c EILtx2tab.c

LINC    =../../include
#=============================================================================#
PCSRC   =$(PSRC:.pc=.c)
POBJS   =$(PSRC:.pc=.o)
COBJS   =$(CSRC:.c=.o)

LIBLARY =$(APLIBS) $(PROLIBS)
SBINDIR =sbin
TARGET  =$(SBINDIR)/$(PROJ)


install  : $(TARGET)

all      : $(PROJ)

$(TARGET): $(PROJ)
	-cp -fp $(PROJ) $(TARGET)

$(PROJ)  : $(POBJS) $(COBJS)
	$(LD) $(LDFLAGS) $(PROJ) $(POBJS) $(COBJS) $(LIBLARY)

$(POBJS) : $(@:.o=.pc) $(LINC)/*.h Makefile
	$(PROC) iname=$(@:.o=.pc) $(PCFLAGS) $(INCLUDE)
	$(CC) $(CFLAGS) $(@:.o=.c)

$(COBJS) : $(@:.o=.c) $(LINC)/*.h Makefile
	$(CC) $(CFLAGS) $(@:.o=.c)

clobber  :
	-rm $(PROJ)
	-rm *.o
	-rm $(PSRC:.pc=.c)
#	-rm *.lis
