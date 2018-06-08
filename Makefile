# makefile for gdbm library for Lua

# change these to reflect your Lua installation
LUA= /tmp/lhf/lua-5.2.2
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
GDBM= /tmp/lhf/gdbm-1.8.3
#GDBM= /tmp/lhf/gdbm-1.10/src
#GDBM= /tmp/lhf/gdbm-1.9.1/src
GDBMINC= -I$(GDBM)
GDBMLIB= $(GDBM)/.libs/libgdbm.a

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G
WARN= -ansi -pedantic -Wall -Wextra
INCS= -I$(LUAINC) $(GDBMINC)
MAKESO= $(CC) -shared
#MAKESO= $(CC) -bundle -undefined dynamic_lookup

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
	$(MAKESO) -o $@ $(OBJS) $(GDBMLIB)

clean:
	rm -f $(OBJS) $T core core.* test.gdbm test.flat

doc:
	@echo "$(MYNAME) library:"
	@fgrep '/**' $(MYLIB).c | cut -f2 -d/ | tr -d '*' | sort | column

# eof
