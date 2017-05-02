#========================================================================#
# Makefile :                                                             #
#========================================================================#
default:install

.SUFFIXES: .pc .c .o

CC       =gcc
AR       =ar
LD       =gcc

MAKEFILE=Makefile

# for Pro*C
#USERID   =ohki/ryutu@ohkidb.world
#PROC     =$(BINHOME)proc
#PROLIBDIR=$(LIBHOME)
#PROLIBS  =$(PROLDLIBS)


# for AP
#APINCDIR =../../include
#APLIBDIR =../../lib
#APLIBS   =-lsap -lscom -lcom

#I_SYM=include=
#INCLUDE=$(I_SYM). $(I_SYM)$(APINCDIR)

#PCFLAGS  =sqlcheck=full userid=$(USERID) ireclen=150 oreclen=150 parse=none lines=yes nls_local=yes DEFINE=__VENDJ__
#PCFLAGS  =sqlcheck=full userid=$(USERID) ireclen=150 oreclen=150 parse=none lines=yes dbms=v7 unsafe_null=yes nls_local=yes

#CFLAGS   =-I. -I$(APINCDIR) $(SQLPUBLIC) -g -ansi -D_HIUX_SOURCE -c -DLINUX -D_GNU_SOURCE -D__DELPHI__
#CFLAGS   =-I. -I$(APINCDIR) $(SQLPUBLIC) -g -D_HIUX_SOURCE -c -DLINUX -D_GNU_SOURCE -D__DELPHI__ -D__OHKI__

#LDFLAGS  =-Wl,-aarchive -L$(APLIBDIR) -L$(PROLIBDIR) -o
#LDFLAGS  =-L$(APLIBDIR) -L$(PROLIBDIR) -o

#=============================================================================#
# PROJ    =<load module name>                                                 #
# PSRC    =<Pro*C source file name>                                           #
# CSRC    =<C Language source file name>                                      #
# LINC    =<include file directry>                                            #
#=============================================================================#
PROJ    =miku
#PSRC    =af845k.pc ldate.pc wtb2tab.pc vinsj.pc cinsj.pc hkyinsj.pc
CSRC    =kadai8_ver2.c

#LINC    =../../include
#=============================================================================#
#PCSRC   =$(PSRC:.pc=.c)
#POBJS   =$(PSRC:.pc=.o)
COBJS   =$(CSRC:.c=.o)

#LIBLARY =$(APLIBS) $(PROLIBS)
#SBINDIR =../../../sbin
#TARGET  =$(SBINDIR)/$(PROJ)


#install  : $(PROJ)
install  : $(COBJS)

all      : $(PROJ)

$(PROJ)  : $(COBJS)
	$(LD) $(PROJ) $(COBJS)

$(COBJS) : $(@:.o=.c) Makefile
	$(CC) -o $(PROJ) $(@:.o=.c)

clobber  :
	-rm *.exe
