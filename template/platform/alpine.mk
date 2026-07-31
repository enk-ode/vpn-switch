# Alpine Linux platform install hooks
#
# Included by the top-level GNUmakefile via 'include template/platform/$(PLATFORM).mk'.
# Alpine uses OpenRC (not systemd): install an init script that brings up a
# saved session, mirroring the systemd 'vpn-switch@<name>' instance pattern via
# OpenRC's symlink-naming convention ('vpn-switch.<name>').

# OpenRC init scripts live under /etc/init.d (not a PREFIX-relative path).
# Override only for staged/packaging installs.
OPENRC_INITDIR ?= /etc/init.d

install-platform:
	@$(INSTALL) -d -m 755 $(DESTDIR)$(OPENRC_INITDIR)
	@$(INSTALL) -m 755 template/platform/alpine/openrc/vpn-switch \
	    $(DESTDIR)$(OPENRC_INITDIR)/vpn-switch
	@echo "  → Alpine: installed OpenRC init script to $(OPENRC_INITDIR)"
	@echo "    Instance:  ln -s /etc/init.d/vpn-switch /etc/init.d/vpn-switch.<name>"
	@echo "    Enable:    rc-update add vpn-switch.<name> default"
	@echo "    Start:     rc-service vpn-switch.<name> start"

uninstall-platform:
	@rm -f $(DESTDIR)$(OPENRC_INITDIR)/vpn-switch
	@echo "  → Alpine: removed OpenRC init script"
