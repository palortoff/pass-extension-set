PREFIX ?= /usr
DESTDIR ?=
LIBDIR ?= $(PREFIX)/lib
SYSTEM_EXTENSION_DIR ?= $(LIBDIR)/password-store/extensions
MANDIR ?= $(PREFIX)/share/man
BASHCOMPDIR ?= /etc/bash_completion.d

all:
	@echo "pass-set is a shell script and does not need compilation, it can be simply executed."
	@echo ""
	@echo "To install it try \"make install\" instead."
	@echo
	@echo "To run pass set one needs to have some tools installed on the system:"
	@echo "     password store"

install:
	@install -v -d "$(DESTDIR)$(MANDIR)/man1"
	@install -v -m 0644 man/pass-extension-set.1 "$(DESTDIR)$(MANDIR)/man1/pass-set.1"
	@install -v -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/"
	@install -v -m0755 src/set.bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/set.bash"
	@install -v -d "$(DESTDIR)$(BASHCOMPDIR)/"
	@install -v -m 644 completion/pass-set.bash.completion  "$(DESTDIR)$(BASHCOMPDIR)/pass-set"
	@echo
	@echo "pass-set is installed succesfully"
	@echo

uninstall:
	@rm -vrf \
		"$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/set.bash" \
		"$(DESTDIR)$(MANDIR)/man1/pass-set.1" \
		"$(DESTDIR)$(BASHCOMPDIR)/pass-set"

lint:
	shellcheck -s bash src/set.bash

.PHONY: install uninstall lint
