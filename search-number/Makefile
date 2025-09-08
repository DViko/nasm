
SRC_DIR   := src
LIB_DIR   := ../lib
BUILD_DIR := build

ASM       := nasm
ASMFLAGS  := -f elf64
LD        := ld

TARGET    := $(BUILD_DIR)/exec
OBJS      := $(BUILD_DIR)/main.o \
			 $(BUILD_DIR)/stringout.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $@ $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR)/stringout.o: $(LIB_DIR)/stringout.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)