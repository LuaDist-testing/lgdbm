# makefile for gdbm library for Lua

# change these to reflect your Lua installation
LUA= /tmp/lhf/lua-5.1.2
LUAINC= $(LUA)/src
LUALIB= $(LUA)/src
LUABIN= $(LUA)/src

# these will probably work if Lua has been installed globally
#LUA= /usr/local
#LUAINC= $(LUA)/include
#LUALIB= $(LUA)/lib
#LUABIN= $(LUA)/bin

# if your system already has gdbm, this should suffice
GDBMLIB= -lgdbm
# otherwise, change these to reflect your gdbm installation
#GDBM= /tmp/lhf/gdbm-1.8.3
#GDBMINC= -I$(GDBM)
#GDBMLIB= -L$(GDBM)/.libs -lgdbm
#GDBMLIB= $(GDBM)/.libs/libgdbm.a

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G
WARN= -ansi -pedantic -Wall
INCS= -I$(LUAINC) $(GDBMINC)

MYNAME= gdbm
MYLIB= l$(MYNAME)
T= $(MYNAME).so
OBJS= $(MYLIB).o
TEST= test.lua

all:	test

test:	$T
	$(LUABIN)/lua $(TEST)

o:	$(MYLIB).o

so:	$T

$T:	$(OBJS)
	$(CC) -o $@ -shared $(OBJS) $(GDBMLIB)

clean:
	rm -f $(OBJS) $T core core.* test.gdbm

doc:
	@echo "$(MYNAME) library:"
	@fgrep '/**' $(MYLIB).c | cut -f2 -d/ | tr -d '*' | sort | column

# distribution

FTP= $(HOME)/public/ftp/lua/5.1
D= $(MYNAME)
A= $(MYLIB).tar.gz
TOTAR= Makefile,README,$(MYLIB).c,test.lua

tar:	clean
	tar zcvf $A -C .. $D/{$(TOTAR)}

distr:	tar
	touch -r $A .stamp
	mv $A $(FTP)

diff:	clean
	tar zxf $(FTP)/$A
	diff $D .

# eof
