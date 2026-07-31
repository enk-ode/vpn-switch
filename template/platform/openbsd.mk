# OpenBSD platform install hooks
#
# Included by the top-level GNUmakefile via 'include template/platform/$(PLATFORM).mk'.
# OpenBSD ships rc.d scripts in /etc/rc.d and manages them with rcctl(8).

# OpenBSD rc.d scripts live in /etc/rc.d (not a PREFIX-relative path).
OPENBSD_RCDIR ?= /etc/rc.d

install-platform:
	@$(INSTALL) -d -m 755 $(DESTDIR)$(OPENBSD_RCDIR)
	@$(INSTALL) -m 555 template/platform/openbsd/rc.d/vpn_switch \
	    $(DESTDIR)$(OPENBSD_RCDIR)/vpn_switch
	@echo "  → OpenBSD: installed rc.d script to $(OPENBSD_RCDIR)"
	@echo "    Enable:  rcctl enable vpn_switch"
	@echo "    Session: rcctl set vpn_switch flags <session>"
	@echo "    Start:   rcctl start vpn_switch"

uninstall-platform:
	@rm -f $(DESTDIR)$(OPENBSD_RCDIR)/vpn_switch
	@echo "  → OpenBSD: removed rc.d script"
