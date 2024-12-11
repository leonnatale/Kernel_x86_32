SOURCE_DIR = source
OUTPUT_DIR = build

OUTPUT_IMG = kernel.img

ASM = nasm
ASM_SOURCE = $(wildcard $(SOURCE_DIR)/*.asm)
ASM_OUTPUT = boot.o
ASM_FLAGS = -f elf32 $(ASM_SOURCE) -o $(OUTPUT_DIR)/$(ASM_OUTPUT)

CC = gcc
CC_SOURCE = $(wildcard $(SOURCE_DIR)/*.c)
CC_OUTPUT = kernel.o
CC_FLAGS = -m32 -c $(CC_SOURCE) -o $(OUTPUT_DIR)/$(CC_OUTPUT)

all: build kernel

build:
	mkdir -p $(OUTPUT_DIR)
	$(ASM) $(ASM_FLAGS)
	$(CC) $(CC_FLAGS)

kernel: build
	ld -m elf_i386 -T link.ld -o $(OUTPUT_DIR)/$(OUTPUT_IMG) $(OUTPUT_DIR)/$(ASM_OUTPUT) $(OUTPUT_DIR)/$(CC_OUTPUT)
	rm -f $(OUTPUT_DIR)/$(ASM_OUTPUT) $(OUTPUT_DIR)/$(CC_OUTPUT)

test:
	qemu-system-i386 -kernel $(OUTPUT_DIR)/$(OUTPUT_IMG)

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean test
