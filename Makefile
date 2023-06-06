INTERNAL_OBJ=__internal_target.o
 
CLEAN_FILES?=
INCLUDE_DIRS?=
LINK_LIBS?=
LINK_LIB_PATH?=
CFLAGS?=
COMPILE_PREFIX?=

ifdef DEBUG
AT=
else
AT=@
endif


ifdef USEGCC
CC=$(COMPILE_PREFIX)gcc
CXX=$(COMPILE_PREFIX)g++
AR=$(COMPILE_PREFIX)ar
LD=$(COMPILE_PREFIX)ld
else
CC=$(COMPILE_PREFIX)clang
CXX=$(COMPILE_PREFIX)clang++
AR=$(COMPILE_PREFIX)llvm-ar
LD=$(COMPILE_PREFIX)lld
endif

-include options.mk
 
dirs:=$(shell find . -maxdepth 1 -type d)
dirs:=$(patsubst ./%,%,$(dirs))
dirs:=$(filter-out .%,$(dirs))
dirs:=$(filter-out $(EXCLUDE_DIRS),$(dirs))
 
SUBDIRS=$(dirs)
 
CFLAGS+= -O3 -Wall
 

$(info $(CC))
$(info $(CXX))

CFILES=$(wildcard *.c)
CPPFILES=$(wildcard *.cpp)
CCFILES=$(wildcard *.cc)

CFILES:=$(filter-out $(EXCLUDE_SRCFILE),$(CFILES))
CPPFILES:=$(filter-out $(EXCLUDE_SRCFILE),$(CPPFILES))
CCFILES:=$(filter-out $(EXCLUDE_SRCFILE),$(CCFILES))

COBJS  :=$(patsubst %.c,%.o,$(CFILES))
CPPOBJS:=$(patsubst %.cpp,%.o,$(CPPFILES))
CPPOBJS+=$(patsubst %.cc,%.o,$(CCFILES))
#$(info $(CPPOBJS))

ALLOBJS:=$(addsuffix /$(INTERNAL_OBJ),$(SUBDIRS))
ALLOBJS:=$(ALLOBJS) $(COBJS) $(CPPOBJS)



CLEAN=clean distclean
.PHONY:$(SUBDIRS) $(CLEAN) $(INTERNAL_OBJ)
 
ifeq ($(strip $(ALLOBJS)),)
$(INTERNAL_OBJ):
	$(AT)$(AR) -rcs $@
else
$(INTERNAL_OBJ):$(COBJS) $(CPPOBJS) $(SUBDIRS)
	$(AT)$(LD) -r $(ALLOBJS) -o $@
endif
 

 
%.o:%.c
	$(AT)$(CC) $(CFLAGS) -c -o $@ $< $(INCLUDE_DIRS) $(LINK_LIB_PATH) -Wl,--start-group $(LINK_LIBS) -Wl,--end-group
%.o:%.cpp
	$(AT)$(CXX) $(CFLAGS) -c -o $@ $< $(INCLUDE_DIRS) $(LINK_LIB_PATH) -Wl,--start-group $(LINK_LIBS) -Wl,--end-group
%.o:%.cc
	$(AT)$(CXX) $(CFLAGS) -c -o $@ $< $(INCLUDE_DIRS) $(LINK_LIB_PATH) -Wl,--start-group $(LINK_LIBS) -Wl,--end-group
$(SUBDIRS):
	$(AT)for everydirectory in $(SUBDIRS);do \
		make -C $$everydirectory;\
	done
$(CLEAN):
	$(AT)rm -rf *.o $(CLEAN_FILES)
	$(AT)for everydirectory in $(SUBDIRS);do \
		make -C $$everydirectory $@;\
	done
	

