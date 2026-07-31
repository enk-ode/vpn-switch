# Linux platform install hooks
#
# Included by the top-level GNUmakefile via 'include template/platform/$(uname).mk'.
# Installs a templated systemd unit so 'systemctl start vpn-switch@<name>'
# brings up a saved session at boot or on demand.

# Where to install the unit. Override on a per-distro basis if needed.
# Defaults follow the convention shared by autotools, RPM and Debian packages
# for non-distro installs into /usr/local.
SYSTEMD_UNITDIR ?= $(PREFIX)/lib/systemd/system

install-platform:
	@$(INSTALL) -d -m 755 $(DESTDIR)$(SYSTEMD_UNITDIR)
	@$(INSTALL) -m 644 template/platform/linux/systemd/vpn-switch@.service \
	    $(DESTDIR)$(SYSTEMD_UNITDIR)/
	@echo "  → Linux: installed systemd unit (vpn-switch@.service) to $(SYSTEMD_UNITDIR)"
	@echo "    Activate:  sudo systemctl daemon-reload"
	@echo "    Customise: sudo systemctl edit vpn-switch@<name>"
	@echo "    Start:     sudo systemctl start vpn-switch@<name>"

uninstall-platform:
	@rm -f $(DESTDIR)$(SYSTEMD_UNITDIR)/vpn-switch@.service
	@echo "  → Linux: removed systemd unit (vpn-switch@.service)"
