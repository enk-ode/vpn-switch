# FreeBSD platform install hooks
#
# Included by the top-level GNUmakefile via '-include template/platform/$(uname).mk'.
# Defines what 'gmake install' and 'gmake uninstall' do beyond the platform-
# agnostic base (script, libs, templates, helpers, docs).
#
# FreeBSD-specific: rc.d service script that integrates vpn-switch with the
# host's service manager (so 'service vpn_switch start' is available).

install-platform:
	@$(INSTALL) -d -m 755 $(DESTDIR)$(RCDIR)
	@$(INSTALL) -m 755 template/platform/freebsd/rc.d/vpn_switch $(DESTDIR)$(RCDIR)/vpn_switch
	@echo "  → FreeBSD: installed rc.d service script"

uninstall-platform:
	@rm -f $(DESTDIR)$(RCDIR)/vpn_switch
	@echo "  → FreeBSD: removed rc.d service script"
