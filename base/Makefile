# Directory
SRC_DIR := src
LIB_DIR := lib
BUILD_DIR := build
BIN_DIR := bin

# Tools
ASM := nasm
LD := ld
STRIP := strip
OBJDUMP := objdump
SIZE := size

# Target binary
TARGET := $(BIN_DIR)/exec

# Source files
SRC := $(wildcard $(SRC_DIR)/*.asm)
LIB := $(wildcard $(LIB_DIR)/*.asm)
FILES := $(SRC) $(LIB)
OBJ := $(FILES:%.asm=$(BUILD_DIR)/%.o)

# -----------------------------
# Default target
# -----------------------------
build: debug

# -----------------------------
# DEBUG build
# -----------------------------
ASMFLAGS_DEBUG := -f elf64 -g -F dwarf
debug: ASMFLAGS=$(ASMFLAGS_DEBUG)
debug: $(TARGET)

# -----------------------------
# RELEASE build
# -----------------------------
ASMFLAGS_RELEASE := -f elf64
release: ASMFLAGS=$(ASMFLAGS_RELEASE)
release: $(TARGET)
	$(STRIP) $(TARGET)

# -----------------------------
# Target binary
# -----------------------------
$(TARGET): $(OBJ)
	mkdir -p $(BIN_DIR)
	$(LD) -o $@ $^

# -----------------------------
# ASM compilation
# -----------------------------
$(BUILD_DIR)/%.o: %.asm
	mkdir -p $(dir $@)
	$(ASM) $(ASMFLAGS) -o $@ $<

# -----------------------------
# Program execution
# -----------------------------
run: build
	@./$(TARGET)

# -----------------------------
# Disassembly
# -----------------------------
disasm: build
	$(OBJDUMP) -d -M intel $(TARGET)

# -----------------------------
# Size information
# -----------------------------
size: build
	$(SIZE) $(TARGET)

# -----------------------------
# Clean build artifacts
# -----------------------------
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

.PHONY: build debug release run disasm size clean