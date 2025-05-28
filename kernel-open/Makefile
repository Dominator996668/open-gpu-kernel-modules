# Определение архитектуры
ifndef ARCH
  ARCH := $(shell uname -m | sed -e 's/i.86/i386/' \
    -e 's/armv[0-7]\w\+/arm/' \
    -e 's/aarch64/arm64/' \
    -e 's/ppc64le/powerpc/' \
    -e 's/riscv64/riscv/')
endif

# Проверка на поддержку архитектуры
ifeq ($(filter $(ARCH),i386 x86_64 arm64 powerpc riscv),)
  $(error Unsupported architecture $(ARCH))
endif

# Определение исходных файлов ядра
KERNEL_SOURCES := $(shell find /lib/modules/$(KERNEL_UNAME)/source -type d -print -quit)
ifeq ($(KERNEL_SOURCES),)
  $(error Kernel source directory not found. Please install kernel headers.)
endif

# Параметры сборки
KBUILD_PARAMS += -C $(KERNEL_SOURCES) M=$(CURDIR) ARCH=$(ARCH)

# Цели сборки
.PHONY: all clean install
all:
	@$(MAKE) $(KBUILD_PARAMS) modules

clean:
	@$(MAKE) $(KBUILD_PARAMS) clean

install:
	@$(MAKE) $(KBUILD_PARAMS) modules_install
