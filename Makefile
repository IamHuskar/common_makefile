INTERNAL_OBJ=__internal_target.o
 
CLEAN_FILES?=
INCLUDE_DIRS?=
LINK_LIBS?=
LINK_LIB_PATH?=
CFLAGS?=
 
 
-include option.mk
 
dirs:=$(shell find . -maxdepth 1 -type d)
dirs:=$(patsubst ./%,%,$(dirs))
dirs:=$(filter-out .%,$(dirs))
dirs:=$(filter-out $(EXCLUDE_DIRS),$(dirs))
 
SUBDIRS=$(dirs)
SUBDIRS+= ../src/
 
CFLAGS+= -O3 -Wall
 
ifdef DEBUG
AT=
else
AT=@
endif
 
 
CFILES=$(wildcard *.c)
CPPFILES=$(wildcard *.cpp)
 
CFILES:=$(filter-out $(EXCLUDE_SRCFILE),$(CFILES))
CPPFILES:=$(filter-out $(EXCLUDE_SRCFILE),$(CPPFILES))
 
COBJS  :=$(patsubst %.c,%.o,$(CFILES))
CPPOBJS:=$(patsubst %.cpp,%.o,$(CPPFILES))
 
ALLOBJS:=$(addsuffix /$(INTERNAL_OBJ),$(SUBDIRS))
ALLOBJS:=$(ALLOBJS) $(COBJS) $(CPPOBJS)
 
CLEAN=clean distclean
.PHONY:$(SUBDIRS) $(CLEAN) $(INTERNAL_OBJ)
 
 
ifeq ($(strip $(ALLOBJS)),)
$(INTERNAL_OBJ):
	$(AT)ar -rcs $@
else
$(INTERNAL_OBJ):$(COBJS) $(CPPOBJS) $(SUBDIRS)
	$(AT)ld -r $(ALLOBJS) -o $@
endif
 
 
 
%.o:%.c
	$(AT)gcc $(CFLAGS) -c -o $@ $< $(INCLUDE_DIRS) $(LINK_LIB_PATH) $(LINK_LIBS)
%.o:%.cpp
	$(AT)g++ $(CFLAGS) -c -o $@ $< $(INCLUDE_DIRS) $(LINK_LIB_PATH) $(LINK_LIBS)
$(SUBDIRS):
	$(AT)for everydirectory in $(SUBDIRS);do \
		make -C $$everydirectory;\
	done
$(CLEAN):
	$(AT)rm -rf *.o $(CLEAN_FILES)
	$(AT)for everydirectory in $(SUBDIRS);do \
		make -C $$everydirectory $@;\
	done
	
