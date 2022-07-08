export LC_CTYPE=C
export PYTHONIOENCODING=utf-8

OUTPUT_PREFIX := dqm_
ORIGINAL_PREFIX := baserom_
VERSION := en
ROM_NAME := DRAGON WMON
ROM_ID := AWQE

# Tools
PYTHON := python3

# Toolchain
CC := rgbasm
CC_ARGS :=
LD := rgblink
LD_ARGS :=
FIX := rgbfix
FIX_ARGS :=
CCGFX := rgbgfx
CCGFX_ARGS := 

# Types
ROM_TYPE := gbc
SYM_TYPE := sym
MAP_TYPE := map
SOURCE_TYPE := asm
INT_TYPE := o

# Directories
## It's important these remain relative
BASE := .
BUILD := $(BASE)/build
GAME := $(BASE)/game
TEXT := $(BASE)/text
GFX := $(BASE)/gfx
SCRIPT := $(BASE)/scripts
SCRIPT_RES := $(SCRIPT)/res

# Game Source Directories
SRC := $(GAME)/src
CORE_SRC := $(SRC)/core

# Build Directories
GFX_OUT := $(BUILD)/gfx
INTERMEDIATES := $(BUILD)/intermediate

# Source Modules (directories in SRC), version directories are implied
MODULES := \
core

# Helper
TOUPPER = $(shell echo '$1' | tr '[:lower:]' '[:upper:]')
FILTER = $(strip $(foreach v,$(2),$(if $(findstring $(1),$(v)),$(v),)))
FILTER_OUT = $(strip $(foreach v,$(2),$(if $(findstring $(1),$(v)),,$(v))))
ESCAPE = $(subst ','\'',$(1))
# Necessary for patsubst expansion
pc := %

# Inputs
ORIGINALS := $(BASE)/$(ORIGINAL_PREFIX)$(VERSION).$(ROM_TYPE)

# Outputs (used by clean)
TARGETS := $(BASE)/$(OUTPUT_PREFIX)$(VERSION).$(ROM_TYPE)
SYM_OUT := $(BASE)/$(OUTPUT_PREFIX)$(VERSION).$(SYM_TYPE)
MAP_OUT := $(BASE)/$(OUTPUT_PREFIX)$(VERSION).$(MAP_TYPE) # Not to be confused with tile/attribute maps

# Sources
OBJNAMES := $(foreach MODULE,$(MODULES),$(addprefix $(MODULE)., $(addsuffix .$(INT_TYPE), $(notdir $(basename $(wildcard $(SRC)/$(MODULE)/*.$(SOURCE_TYPE)))))))
COMMON_SRC_FILES := $(wildcard $(COMMON_SRC)/*.$(SOURCE_TYPE))

# Intermediates for common sources (not in version folder)
## We explicitly rely on second expansion to handle version-specific files in the version specific objects
OBJECTS := $(foreach OBJECT,$(OBJNAMES), $(addprefix $(BUILD)/,$(OBJECT)))

# Additional dependencies, per module granularity (i.e. core) or per file granularity (e.g. core_main_ADDITIONAL)


.PHONY: $(VERSION) all clean default test
default: en
all: $(VERSION)

clean:
	rm -r $(BUILD) $(TARGETS) $(SYM_OUT) $(MAP_OUT) || exit 0

$(VERSION): %: $(OUTPUT_PREFIX)%.$(ROM_TYPE)

# $| is a hack, we cannot have any other order-only prerequisites
.SECONDEXPANSION:
$(BASE)/$(OUTPUT_PREFIX)%.$(ROM_TYPE): $(OBJECTS) | $(BASE)/$(ORIGINAL_PREFIX)%.$(ROM_TYPE)
	$(LD) $(LD_ARGS) -n $(OUTPUT_PREFIX)$*.$(SYM_TYPE) -m $(OUTPUT_PREFIX)$*.$(MAP_TYPE) -O $| -o $@ $^
	$(FIX) $(FIX_ARGS) -v -c -k 4F -l 0x33 -m 0x1B -p 0 -r 2 $@ -i "$(ROM_ID)" -t "$(ROM_NAME)"
	cmp -l $| $@

# Build objects
.SECONDEXPANSION:
.SECONDARY: # Don't delete intermediate files
$(BUILD)/%.$(INT_TYPE): $(SRC)/$$(firstword $$(subst ., ,$$*))/$$(lastword $$(subst ., ,$$*)).$(SOURCE_TYPE) $(COMMON_SRC_FILES) $$(wildcard $(SRC)/$$(firstword $$(subst ., ,$$*))/include/*.$(SOURCE_TYPE)) $$($$(firstword $$(subst ., ,$$*))_ADDITIONAL) $$($$(firstword $$(subst ., ,$$*))_$$(lastword $$(subst ., ,$$*))_ADDITIONAL) $$(subst PLACEHOLDER_VERSION,$$(lastword $$(subst /, ,$$(firstword $$(subst ., ,$$*)))),$$($$(firstword $$(subst /, ,$$*))_$$(lastword $$(subst ., ,$$*))_ADDITIONAL)) | $$(patsubst $$(pc)/,$$(pc),$$(dir $$@)) $(VERSION_OUT)
	$(CC) $(CC_ARGS) -DGAMEVERSION=$(VERSION) -o $@ $<

### Dump Scripts

.PHONY:
dump:

#Make directories if necessary
$(BUILD):
	mkdir -p $(BUILD)

$(SCRIPT_RES):
	mkdir -p $(SCRIPT_RES)