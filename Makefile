# Makefile for assembling bootloader.asm using NASM on macOS

# Define the assembler and its flags
ASSEMBLER = nasm
ASSEMBLER_FLAGS = -f bin

# Define the source and output file names
SRC_FILE = src/bootloader.asm
OUT_FILE = build/bootloader.bin

all: $(OUT_FILE)

$(OUT_FILE): $(SRC_FILE)
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $@ $<

clean:
	rm -f $(OUT_FILE)

.PHONY: all clean
