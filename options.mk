#option.mk specific flags
#
#CLEAN_FILES
# make clean or make distclean
#example
# CLEAN_FILES+= filea.o fileb.o filec.o
#
#
#INCLUDE_DIRS
#gcc g++ include directory
# example 
#INCLUDE_DIRS+= -I/usr/xxx/include -I../../
#
#
#
#LINK_LIB_PATH
#gcc g++ lib search path
#LINK_LIB_PATH+= -L/lib/xxx/ -L../libx86/
#
#
#
#gcc g++ link library
#LINK_LIBS
#example 
#LINK_LIBS+= -lboost_system -lpthread
#
#
#
#
#CFLAGS
#example
#CFLAGS+= -O3 -Wall -std=c++0x
#-std==c++11
#
#
#EXCLUDE_DIRS
#
#example 
#EXCLUDE_DIRS += doc 
#exclude build dir in current directory
#
#
#
#
#
#
#EXCLUDE_SRCFILE
#example
#EXCLUDE_SRCFILE+= a.c b.c m.cpp w.cpp
#exclude srcfiles in current directory
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
 
#EXCLUDE_DIRS+=common
#CFLAGS+= -std=c++0x
#INCLUDE_DIRS+= -I../header/
 
################################
#
#  build binary example
#
#TARGET_BIN=main
#$(TARGET_BIN):$(INTERNAL_OBJ)
#	g++ -o $(TARGET_BIN) $(CFLAGS) $(INTERNAL_OBJ) $(INCLUDE_DIRS) $(LINK_LIB_PATH) $(LINK_LIBS)
#	strip $(TARGET_BIN)
#
#
#
################################
 
################################
#
#  build shared library example
#
#CFLAGS+= -std=c++0x -fPIC
#TARGET_SHARED_LIB=libeasycnn.so
#$(TARGET_SHARED_LIB):$(INTERNAL_OBJ)
#	g++ -o $(TARGET_SHARED_LIB) $(CFLAGS) -shared  $(INTERNAL_OBJ)
#	strip $(TARGET_SHARED_LIB)
#CLEAN_FILES+=$(TARGET_SHARED_LIB)
 
#
#
#
################################
 
 
################################
#
#  build static library example
#
#CFLAGS+= -std=c++0x
#TARGET_STATIC_LIB=libmystatic.a
#$(TARGET_STATIC_LIB):$(INTERNAL_OBJ)
#	ar rc $(TARGET_STATIC_LIB) $(INTERNAL_OBJ)
#CLEAN_FILES+=$(TARGET_STATIC_LIB)
#
################################
 
#LINK_LIBS+= -lpthread
#TARGET_BIN=main
#$(TARGET_BIN):$(INTERNAL_OBJ)
#	g++ -o $(TARGET_BIN) $(CFLAGS) $(INTERNAL_OBJ) $(INCLUDE_DIRS) $(LINK_LIB_PATH) $(LINK_LIBS)
#	strip $(TARGET_BIN)

