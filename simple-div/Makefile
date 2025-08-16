# Makefile for division project

# Папки
SRC_DIR   := .
PRINT_LIB_DIR   := ../lib/string-out
#MATH_LIB_DIR   := ../lib/calc
BUILD_DIR := build

# Инструменты
ASM       := nasm
ASMFLAGS  := -f elf64
LD        := ld

# Файлы
TARGET    := $(BUILD_DIR)/simplediv
OBJS      := $(BUILD_DIR)/main.o \
			 $(BUILD_DIR)/stringout.o
#			 $(BUILD_DIR)/calc.o

# Цель по умолчанию
all: $(TARGET)

# Сборка
$(TARGET): $(OBJS)
	$(LD) -o $@ $^

# Компиляция .asm -> .o
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR)/stringout.o: $(PRINT_LIB_DIR)/stringout.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

#$(BUILD_DIR)/calc.o: $(MATH_LIB_DIR)/calc.asm | $(BUILD_DIR)
#	$(ASM) $(ASMFLAGS) -o $@ $<

# Создание папки build/
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Очистка
clean:
	rm -rf $(BUILD_DIR)