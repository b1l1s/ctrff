export PATH	:=	$(DEVKITARM)/bin:$(PATH)

CC:=arm-none-eabi-gcc
CP:=arm-none-eabi-g++
OC:=arm-none-eabi-objcopy 
LD:=arm-none-eabi-ld
AR:=arm-none-eabi-ar

LIBNAME:=ctrff

SRC_DIR:=src
OBJ_DIR:=obj
LIB_DIR:=lib
DEP_DIR:=obj

INCPATHS=-Iinclude/ctrff

THUMBFLAGS:=-mthumb -mthumb-interwork
CFLAGS:=-std=gnu99 -g -Os -mword-relocations -fomit-frame-pointer -ffast-math $(INCPATHS) $(THUMBFLAGS)
C9FLAGS:=-mcpu=arm946e-s -march=armv5te -mlittle-endian
LDFLAGS:=
OCFLAGS:=--set-section-flags .bss=alloc,load,contents

OBJS:=$(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(wildcard $(SRC_DIR)/*.c))
OBJS+=$(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(wildcard $(SRC_DIR)/*.s))
OBJS+=$(patsubst $(SRC_DIR)/%.S, $(OBJ_DIR)/%.o, $(wildcard $(SRC_DIR)/*.S))

OUT_DIR:=$(LIB_DIR) $(OBJ_DIR) $(OBJ_DIR)/option
LIB:=$(LIB_DIR)/lib$(LIBNAME).a

.PHONY: clean all install

all: $(LIB)

$(LIB): $(OBJS) | dirs
	$(AR) -rcs $@ $(OBJS)

obj/%.o: src/%.c | dirs
	@echo Compiling $<
	$(CC) $(CFLAGS) $(C9FLAGS) -c $< -o $@

obj/%.o: src/%.s | dirs
	@echo Compiling $<
	$(CC) -c $(CFLAGS) $(C9FLAGS) $< -o $@

obj/%.o: src/%.S | dirs
	@echo Compiling $<
	$(CC) -c $(CFLAGS) $(C9FLAGS) $< -o $@

dirs: ${OUT_DIR}

${OUT_DIR}:
	mkdir -p ${OUT_DIR}

install: all
	cp -r include/* $(DEVKITARM)/arm-none-eabi/include
	cp $(LIB) $(DEVKITARM)/arm-none-eabi/lib

clean:
	rm -rf lib/* obj/*
