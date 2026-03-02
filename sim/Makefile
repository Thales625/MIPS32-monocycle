SIM ?= modelsim
# SIM ?= questa

TOPLEVEL_LANG ?= vhdl

VHDL_DIR = $(PWD)/../vhdl

VHDL_SOURCES += $(VHDL_DIR)/Adder.vhd
VHDL_SOURCES += $(VHDL_DIR)/Mux2_1.vhd
VHDL_SOURCES += $(VHDL_DIR)/Reg.vhd
VHDL_SOURCES += $(VHDL_DIR)/RegFile.vhd
VHDL_SOURCES += $(VHDL_DIR)/ULA.vhd
VHDL_SOURCES += $(VHDL_DIR)/ULA_Operation.vhd
VHDL_SOURCES += $(VHDL_DIR)/Shifter.vhd
VHDL_SOURCES += $(VHDL_DIR)/MemInst.vhd
VHDL_SOURCES += $(VHDL_DIR)/MemData.vhd
VHDL_SOURCES += $(VHDL_DIR)/ControlUnit.vhd
VHDL_SOURCES += $(VHDL_DIR)/Processor.vhd

# VHDL TopLevel entity name
TOPLEVEL = processor

# python file name (without .py)
MODULE = main

# flags
# COMPILE_ARGS += -2008

include $(shell cocotb-config --makefiles)/Makefile.sim
