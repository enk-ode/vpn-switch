# GNUmakefile for vpn-switch
# Compatible with FreeBSD and Debian/Linux (uses GNU make features — on
# FreeBSD install 'devel/gmake' and invoke as 'gmake').
#
# Usage:
#   make                    - Show help
#   make platform           - Set repo platform symlink (do this after clone)
#   make test               - Run all tests
#   make install            - Install to PREFIX (default: /usr/local)
#   make install PREFIX=/usr - Install to /usr
#   make uninstall          - Remove installed files
#
# For development:
#   make metadata           - Regenerate function metadata
#   make check              - Syntax check
#   make shellcheck         - Run shellcheck linter
#   make lint               - Run all linters (check + shellcheck)
#   make clean              - Remove build artifacts

SHELL := /bin/sh

#-----------------------------------------------------------------------------
# Installation paths (FHS-compliant)
#-----------------------------------------------------------------------------

# Base installation prefix
PREFIX      ?= /usr/local

# Staging directory (for package building)
DESTDIR     ?=

# Binary directory (main script; user-runnable, never needs root).
# /bin (not /sbin): vpn-switch itself does not require privileges —
# privilege escalation happens per-function via interpreter directives
# (sudo sh) only for the network operations that need it.
BINDIR      := $(PREFIX)/bin

# System binary directory (root-only helpers).
# resolvconf-up/down scripts that mutate DNS and reload local_unbound live
# here. Phase scripts call them via their absolute /usr/local/sbin paths.
SBINDIR     := $(PREFIX)/sbin

# Package-private library directory (include/, template/).
# Holds both shell modules and template/data — see INSTALL.md for the FHS
# rationale (package-private trees are an accepted FHS pattern).
LIBDIR      := $(PREFIX)/lib/vpn-switch

# Documentation directory
DOCDIR      := $(PREFIX)/share/doc/vpn-switch

# Man page directory (future)
MANDIR      := $(PREFIX)/share/man/man1

# rc.d directory (FreeBSD service script; used by freebsd.mk plugin)
RCDIR       := $(PREFIX)/etc/rc.d

#-----------------------------------------------------------------------------
# Source files
#-----------------------------------------------------------------------------

SCRIPT      := vpn-switch.sh
BUILD_DIR   := .build
INDEX_DIR   := $(BUILD_DIR)/index

# Helper scripts (DNS resolvconf integration — currently FreeBSD-specific,
# called by template/phase/{wireguard,base}/.../dns.sh from $(SBINDIR)/).
HELPER_SCRIPTS := \
    template/phase/base/dns/resolvconf/wg-resolvconf-up \
    template/phase/base/dns/resolvconf/wg-resolvconf-down \
    template/phase/base/dns/resolvconf/ovpn-resolvconf-up \
    template/phase/base/dns/resolvconf/ovpn-resolvconf-down

# Documentation files
DOC_FILES := \
    README.md \
    LICENSE \
    QUICK_REFERENCE.md

#-----------------------------------------------------------------------------
# Platform detection + plugin loading
#-----------------------------------------------------------------------------

# Platform name — drives both the 'platform' target and the plugin filename.
# Two-level detection: the kernel name (uname) is enough for the BSDs, but it
# can't tell Alpine (busybox + OpenRC) from Debian/Ubuntu (coreutils + systemd)
# — both report "Linux". So for Linux we refine via /etc/os-release's ID.
# Keep this logic in sync with include/validate.sh (_install_validate0) and
# vpn-switch-integration-test.sh (install-layout check).
# (if/else, not case: make counts parens to close $(shell ...), and the ')' in
# case patterns like 'alpine)' would close it prematurely.)
PLATFORM    := $(shell kernel=$$(uname -s | tr A-Z a-z); \
	if [ "$$kernel" = linux ] && [ -r /etc/os-release ]; then \
		id=$$(. /etc/os-release 2>/dev/null; echo $$ID); \
		if [ "$$id" = alpine ]; then echo alpine; else echo linux; fi; \
	else echo "$$kernel"; fi)

# install command — same name on FreeBSD (BSD install) and Linux (GNU coreutils).
# Per-platform flag differences live in the per-platform .mk plugin if needed.
INSTALL     := install

# Per-platform install hooks live in template/platform/$(PLATFORM).mk
# (freebsd.mk, linux.mk). Each provides 'install-platform' and
# 'uninstall-platform' target recipes; this main file just calls them.
#
# 'include' (not '-include'): if the .mk is missing, the build fails loudly
# with a clear path to the missing file. To port to a new OS, drop in a new
# .mk and the rest of the Makefile keeps working unchanged.
include template/platform/$(PLATFORM).mk

#-----------------------------------------------------------------------------
# Targets
#-----------------------------------------------------------------------------

.PHONY: all help platform install install-base install-platform \
        uninstall uninstall-base uninstall-platform \
        test test-unit test-integration test-arch \
        metadata manpage check shellcheck lint clean

# Default target: show help
all: help

help:
	@echo "vpn-switch - VPN configuration management"
	@echo ""
	@echo "Development (operates only in the repo):"
	@echo "  make platform             Set repo's template/platform/default symlink"
	@echo "  make test                 Run all tests"
	@echo "  make test-unit            Run unit tests only"
	@echo "  make test-integration     Run integration tests only"
	@echo "  make test-arch            Run architecture tests only"
	@echo "  make metadata             Regenerate function metadata + template/VERSION"
	@echo "  make manpage              Regenerate docs/vpn-switch.{1,html} from .1.md (needs pandoc)"
	@echo "  make check                Syntax check all scripts"
	@echo "  make shellcheck           Run shellcheck linter"
	@echo "  make lint                 Run all linters (check + shellcheck)"
	@echo "  make clean                Remove build artifacts"
	@echo ""
	@echo "Installation (operates on \$$(DESTDIR)\$$(PREFIX)):"
	@echo "  make install              Install to $(PREFIX)"
	@echo "  make install PREFIX=/usr  Install to /usr"
	@echo "  make install DESTDIR=/staging  Stage install for packaging"
	@echo "  make uninstall            Remove installed files"
	@echo ""
	@echo "Variables:"
	@echo "  PREFIX   = $(PREFIX)"
	@echo "  DESTDIR  = $(DESTDIR)"
	@echo "  BINDIR   = $(BINDIR)"
	@echo "  SBINDIR  = $(SBINDIR)"
	@echo "  LIBDIR   = $(LIBDIR)"
	@echo "  DOCDIR   = $(DOCDIR)"
	@echo "  PLATFORM = $(PLATFORM)"
	@echo ""
	@echo "Post-installation:"
	@echo "  1. Verify install:        vpn-switch validate"
	@echo "  2. Initialize database:   vpn-switch bootstrap ~/.vpn-switch/db minimal"
	@echo "  3. Import VPN config:     vpn-switch wireguard import /path/to/config.conf"

#-----------------------------------------------------------------------------
# Repo-only convenience: set platform symlink in the SOURCE TREE so tests
# and ad-hoc './vpn-switch.sh' invocations from a fresh clone work right away.
# Does NOT touch the install destination — see 'install' for that.
#-----------------------------------------------------------------------------

platform:
	@echo "Setting repo platform: template/platform/default → $(PLATFORM).sh"
	@cd template/platform && rm -f default && ln -s $(PLATFORM).sh default
	@ls -l template/platform/default

#-----------------------------------------------------------------------------
# Installation
#
# install        = install-base + install-platform (plugin hook from .mk)
# install-base   = platform-agnostic file copy + symlink in destination
# install-platform = OS-specific extras (rc.d on FreeBSD, systemd on Linux later)
#-----------------------------------------------------------------------------

install: metadata install-base install-platform
	@echo ""
	@echo "Installation complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Verify installation:   vpn-switch validate"
	@echo "  2. Initialize database:   vpn-switch bootstrap ~/.vpn-switch/db minimal"
	@echo "  3. Import VPN config:     vpn-switch wireguard import /path/to/config.conf"

# install-base copies the platform-agnostic file set:
#   - Main script to $(BINDIR) (with $(LIBDIR) baked in via sed)
#   - resolvconf helpers to $(SBINDIR) (root-only; reload local_unbound).
#     Phase scripts call them by absolute /usr/local/sbin paths so this is
#     a contract.
#   - include/ modules and template/ tree to $(LIBDIR) (package-private)
#   - Documentation to $(DOCDIR)
#   - Platform symlink in the install destination (NOT the repo — that's
#     what the 'platform' target is for)
install-base:
	@echo "Installing vpn-switch (base) to $(DESTDIR)$(PREFIX)..."
	@$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
	@$(INSTALL) -d -m 755 $(DESTDIR)$(SBINDIR)
	@$(INSTALL) -d -m 755 $(DESTDIR)$(LIBDIR)
	@$(INSTALL) -d -m 755 $(DESTDIR)$(LIBDIR)/include
	@$(INSTALL) -d -m 755 $(DESTDIR)$(LIBDIR)/template
	@$(INSTALL) -d -m 755 $(DESTDIR)$(DOCDIR)
	@$(INSTALL) -d -m 755 $(DESTDIR)$(MANDIR)
	@sed 's|: "$${VPN_SWITCH_LIBDIR:=.*}"|: "$${VPN_SWITCH_LIBDIR:=$(LIBDIR)}"|' \
	    $(SCRIPT) > $(DESTDIR)$(BINDIR)/vpn-switch
	@chmod 755 $(DESTDIR)$(BINDIR)/vpn-switch
	@for script in $(HELPER_SCRIPTS); do \
	    $(INSTALL) -m 755 $$script $(DESTDIR)$(SBINDIR)/; \
	done
	@$(INSTALL) -m 644 include/*.sh $(DESTDIR)$(LIBDIR)/include/
	@cp -R template/* $(DESTDIR)$(LIBDIR)/template/
	@find $(DESTDIR)$(LIBDIR)/template -type f -exec chmod 644 {} \;
	@find $(DESTDIR)$(LIBDIR)/template -type d -exec chmod 755 {} \;
	@cd $(DESTDIR)$(LIBDIR)/template/platform && rm -f default && ln -s $(PLATFORM).sh default
	@for doc in $(DOC_FILES); do \
	    if [ -f "$$doc" ]; then $(INSTALL) -m 644 "$$doc" $(DESTDIR)$(DOCDIR)/; fi; \
	done
	@if [ -f docs/vpn-switch.1 ]; then \
	    $(INSTALL) -m 644 docs/vpn-switch.1 $(DESTDIR)$(MANDIR)/vpn-switch.1; \
	fi
	@echo "  → installed script, helpers, libs, templates, docs, man page"
	@echo "  → platform symlink: $(PLATFORM).sh"

uninstall: uninstall-platform uninstall-base

uninstall-base:
	@echo "Uninstalling vpn-switch (base) from $(DESTDIR)$(PREFIX)..."
	@rm -f $(DESTDIR)$(BINDIR)/vpn-switch
	@for script in $(HELPER_SCRIPTS); do \
	    rm -f $(DESTDIR)$(SBINDIR)/`basename $$script`; \
	done
	@rm -rf $(DESTDIR)$(LIBDIR)
	@rm -rf $(DESTDIR)$(DOCDIR)
	@rm -f $(DESTDIR)$(MANDIR)/vpn-switch.1
	@echo "  → removed script, helpers, libs, templates, docs, man page"

#-----------------------------------------------------------------------------
# Testing
#-----------------------------------------------------------------------------

test: metadata
	@echo "Running all tests..."
	@echo ""
	@echo "=== Unit Tests ==="
	@sh vpn-switch-unit-test.sh minimal
	@echo ""
	@echo "=== Integration Tests ==="
	@sh vpn-switch-integration-test.sh minimal
	@echo ""
	@echo "=== Architecture Tests ==="
	@sh vpn-switch-architecture-test.sh minimal

test-unit: metadata
	@echo "Running unit tests..."
	@sh vpn-switch-unit-test.sh minimal

test-integration: metadata
	@echo "Running integration tests..."
	@sh vpn-switch-integration-test.sh minimal

test-arch: metadata
	@echo "Running architecture tests..."
	@sh vpn-switch-architecture-test.sh minimal

#-----------------------------------------------------------------------------
# Development
#-----------------------------------------------------------------------------

metadata:
	@echo "Generating function metadata (vpn-switch.sh + embedded test copies)..."
	@sh scripts/generate-metadata.sh
	@for f in $$(grep -lF '# === AUTO-GENERATED METADATA' *-test.sh scripts/vpn-switch-walkthrough.sh); do \
	    printf '  + %s\n' "$$f"; \
	    sh scripts/generate-metadata.sh --target "$$f" >/dev/null; \
	done
	@echo "Generating template/VERSION..."
	@git rev-parse HEAD > template/VERSION 2>/dev/null || echo "unknown" > template/VERSION
	@echo "  template/VERSION: $$(cat template/VERSION)"

# Regenerate man page (groff) and HTML rendering from the single Markdown
# source. Both outputs are committed so packagers/users don't need pandoc;
# only contributors editing the manpage source need it.
manpage:
	@command -v pandoc >/dev/null 2>&1 || { \
	    echo "pandoc not found. Install with:"; \
	    echo "  FreeBSD: pkg install hs-pandoc"; \
	    echo "  Debian:  apt install pandoc"; \
	    exit 1; \
	}
	@echo "Regenerating COMMANDS section from #@help corpus..."
	@sh scripts/generate-help-manpage.sh
	@echo "Generating docs/vpn-switch.1 (groff man page)..."
	@pandoc -s -t man docs/vpn-switch.1.md -o docs/vpn-switch.1
	@echo "Generating docs/vpn-switch.html (web rendering)..."
	@pandoc -s -t html5 --css=man.css docs/vpn-switch.1.md -o docs/vpn-switch.html
	@cp docs/vpn-switch.html docs/index.html   # GitHub Pages landing page (served from /docs)
	@echo "  → docs/vpn-switch.1"
	@echo "  → docs/vpn-switch.html"
	@echo "  → docs/index.html (GitHub Pages)"
	@echo "  Preview man:  man ./docs/vpn-switch.1"
	@echo "  Preview html: \$$BROWSER docs/vpn-switch.html"

check:
	@echo "Syntax check: $(SCRIPT)"
	@sh -n $(SCRIPT) && echo "  OK"
	@echo "Syntax check: vpn-switch-unit-test.sh"
	@sh -n vpn-switch-unit-test.sh && echo "  OK"
	@echo "Syntax check: vpn-switch-integration-test.sh"
	@sh -n vpn-switch-integration-test.sh && echo "  OK"
	@echo "Syntax check: vpn-switch-architecture-test.sh"
	@sh -n vpn-switch-architecture-test.sh && echo "  OK"
	@echo ""
	@echo "All syntax checks passed."

# ShellCheck linting (requires shellcheck to be installed)
# Configuration in .shellcheckrc, documentation in docs/SHELLCHECK.md
shellcheck:
	@echo "Running shellcheck (using .shellcheckrc)..."
	@if command -v shellcheck >/dev/null 2>&1; then \
	    echo "Checking: $(SCRIPT)"; \
	    shellcheck $(SCRIPT) && echo "  OK" || true; \
	    echo "Checking: vpn-switch-unit-test.sh"; \
	    shellcheck vpn-switch-unit-test.sh && echo "  OK" || true; \
	    echo "Checking: vpn-switch-integration-test.sh"; \
	    shellcheck vpn-switch-integration-test.sh && echo "  OK" || true; \
	    echo "Checking: vpn-switch-architecture-test.sh"; \
	    shellcheck vpn-switch-architecture-test.sh && echo "  OK" || true; \
	    echo "Checking: include/*.sh"; \
	    shellcheck include/*.sh && echo "  OK" || true; \
	    echo ""; \
	    echo "ShellCheck complete."; \
	else \
	    echo "shellcheck not found. Install with:"; \
	    echo "  FreeBSD: pkg install hs-ShellCheck"; \
	    echo "  Debian:  apt install shellcheck"; \
	    exit 1; \
	fi

lint: check shellcheck
	@echo ""
	@echo "All linting complete."

clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	find . -name "*.bak" -delete
	@echo "Clean complete."

#-----------------------------------------------------------------------------
# Development utilities
#-----------------------------------------------------------------------------

.PHONY: index functions stats

# Generate comprehensive index
index: $(INDEX_DIR)/functions.txt $(INDEX_DIR)/anchors.txt
	@echo "Index generated in $(INDEX_DIR)/"
	@ls -lh $(INDEX_DIR)/

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(INDEX_DIR): $(BUILD_DIR)
	@mkdir -p $(INDEX_DIR)

$(INDEX_DIR)/functions.txt: $(SCRIPT) $(INDEX_DIR)
	@grep -n '^[_a-zA-Z][_a-zA-Z0-9]*()' $(SCRIPT) > $@ || true

$(INDEX_DIR)/anchors.txt: $(SCRIPT) $(INDEX_DIR)
	@grep -n '^_[a-z_]*[0-9]()' $(SCRIPT) > $@ || true

functions: $(INDEX_DIR)/functions.txt
	@echo "=== All Functions ==="
	@cat $(INDEX_DIR)/functions.txt

stats: metadata
	@echo "=== Code Statistics ==="
	@echo "Total lines:        $$(wc -l < $(SCRIPT))"
	@echo "Functions:          $$(grep -c '^[_a-zA-Z][_a-zA-Z0-9]*()' $(SCRIPT))"
	@echo "Anchor functions:   $$(grep -c '^_[a-z_]*[0-9]()' $(SCRIPT))"
	@echo "Include modules:    $$(ls include/*.sh 2>/dev/null | wc -l)"
	@echo "Template files:     $$(find template -type f | wc -l)"
