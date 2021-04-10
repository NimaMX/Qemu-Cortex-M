PROJECT_NAME = arm-cortexM-qemu

# Path to toolchain
TOOLCHAIN_PATH ?= /usr/bin

# Env
CC			=		$(TOOLCHAIN_PATH)/arm-none-eabi-gcc
LD			=		$(TOOLCHAIN_PATH)/arm-none-eabi-gcc
AR			=		$(TOOLCHAIN_PATH)/arm-none-eabi-ar
AS			=		$(TOOLCHAIN_PATH)/arm-none-eabi-as
OBJCOPY =		$(TOOLCHAIN_PATH)/arm-none-eabi-objcopy
OBJDUMP =		$(TOOLCHAIN_PATH)/arm-none-eabi-objdump
SIZE		=		$(TOOLCHAIN_PATH)/arm-none-eabi-size

SRC			=		$(wildcard *.c)
ASRC		=		$(wildcard *.s)
OBJ			=		$(SRC:.c=.o) $(ASRC:.s=.o)
LD_SCRIPT = qemu.ld

# Compiler and Linker flags
CFLAGS += -mcpu=arm926ej-s -g -mlittle-endian -mthumb -Wall -fdata-sections -ffunction-sections -Og
LFLAGS += -T$(LD_SCRIPT) -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs

.PHONY: all clean hex bin

all: $(PROJECT_NAME).elf

$(PROJECT_NAME).elf: $(OBJ)
		$(CC) $(CFLAGS) $(OBJ) -o $@ $(LFLAGS)
		$(SIZE) $(PROJECT_NAME).elf

%.o: %.c $(DEPS)
		$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s $(DEPS)
		$(CC) $(CFLAGS) -c $< -o $@

hex: $(PROJECT_NAME).elf
		$(OBJCOPY) -O ihex $(PROJECT_NAME).elf $(PROJECT_NAME).hex

bin: $(PROJECT_NAME).elf
		$(OBJCOPY) -O binary $(PROJECT_NAME).elf $(PROJECT_NAME).bin

clean:
		rm -f $(OBJ) $(PROJECT_NAME).elf $(PROJECT_NAME).hex $(PROJECT_NAME).bin *.d
