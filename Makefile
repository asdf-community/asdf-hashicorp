SH_SRCFILES = $(shell git ls-files "bin/*" "test/*")
SHFMT_BASE_FLAGS = -s -i 2 -ci

format:
	shfmt -w $(SHFMT_BASE_FLAGS) $(SH_SRCFILES)
.PHONY: format

format-check:
	shfmt -d $(SHFMT_BASE_FLAGS) $(SH_SRCFILES)
.PHONY: format-check

lint:
	shellcheck $(SH_SRCFILES)
.PHONY: lint

test:
	bats test
.PHONY: test
