DEFAULT_YOUTUBE_IPA := ./ipa/YouTube_4.54.01_decrypted.ipa
AUTO_YOUTUBE_IPAS := $(filter-out ./ipa/.DS_Store,$(wildcard ./ipa/*.ipa))
YOUTUBE_IPA := $(DEFAULT_YOUTUBE_IPA)
OUTPUT_IPA := ./mutube.ipa
PATCHER_FLAGS :=

ifeq ($(origin IPA), command line)
YOUTUBE_IPA := $(IPA)
else ifneq ($(wildcard $(DEFAULT_YOUTUBE_IPA)),)
YOUTUBE_IPA := $(DEFAULT_YOUTUBE_IPA)
else ifeq ($(words $(AUTO_YOUTUBE_IPAS)),1)
YOUTUBE_IPA := $(firstword $(AUTO_YOUTUBE_IPAS))
else ifneq ($(words $(AUTO_YOUTUBE_IPAS)),0)
$(error Multiple IPA files found in ./ipa. Use `make IPA=./ipa/<file>.ipa` to choose one)
else
$(error No input IPA found. Put a decrypted IPA in ./ipa/ or run `make IPA=/path/to/YouTube.ipa`)
endif

ifeq ($(wildcard $(YOUTUBE_IPA)),)
$(error IPA file not found: $(YOUTUBE_IPA))
endif

ifneq ($(PRINTF_LOGS),)
ifneq ($(PRINTF_LOGS),0)
PATCHER_FLAGS += --enable-printf-logs
endif
endif

.PHONY: all help
all: $(OUTPUT_IPA)

help:
	@printf '%s\n' \
		'Usage: make [IPA=./ipa/YouTube_decrypted.ipa] [PRINTF_LOGS=1]' \
		'' \
		'Input IPA resolution order:' \
		'1. IPA=... passed on the command line' \
		'2. ./ipa/YouTube_4.54.01_decrypted.ipa if present' \
		'3. The only .ipa file found under ./ipa/'

$(OUTPUT_IPA): $(YOUTUBE_IPA) patcher.py inject.js
	uv run patcher.py --in $(YOUTUBE_IPA) --out $(OUTPUT_IPA) $(PATCHER_FLAGS)

.PHONY: clean
clean:
	rm -f $(OUTPUT_IPA)
