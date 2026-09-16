# FreeBSD platform install hooks
#
# Included by the top-level GNUmakefile via '-include template/platform/$(uname).mk'.
# Defines what 'gmake install' and 'gmake uninstall' do beyond the platform-
# agnostic base (script, libs, templates, helpers, docs).
#
# FreeBSD-specific: boot integration through rc.d and devd. The service
# vpn_switch brings the saved default session up before the time daemons and
# whenever the uplink reports LINK_UP. It runs vpn-switch as the user whose
# database holds the sessions - derived from the user running
# 'sudo gmake install' (SUDO_USER), overridable on the command line:
#
#   sudo gmake install VPN_SWITCH_RC_USER=alice VPN_SWITCH_RC_IFNAME=em0
#
# The derived settings land in $(RCCONFDIR)/vpn_switch (written only when the
# file does not exist yet, so local edits survive reinstalls). Enabling is
# left to the admin: sysrc vpn_switch_enable=YES; service devd restart.

VPN_SWITCH_RC_USER   ?= $(if $(SUDO_USER),$(SUDO_USER),$(shell id -un))
VPN_SWITCH_RC_HOME   ?= $(shell pw usershow $(VPN_SWITCH_RC_USER) 2>/dev/null | cut -d: -f9)
VPN_SWITCH_RC_BASE   ?= $(VPN_SWITCH_RC_HOME)/.vpn-switch/db
VPN_SWITCH_RC_IFNAME ?= lagg0
RCCONFDIR := $(PREFIX)/etc/rc.conf.d
DEVDDIR   := $(PREFIX)/etc/devd

install-platform:
	@$(INSTALL) -d -m 755 $(DESTDIR)$(RCDIR) $(DESTDIR)$(RCCONFDIR) $(DESTDIR)$(DEVDDIR)
	@$(INSTALL) -m 755 template/platform/freebsd/rc.d/vpn_switch $(DESTDIR)$(RCDIR)/vpn_switch
	@sed 's|@IFNAME@|$(VPN_SWITCH_RC_IFNAME)|g' template/platform/freebsd/devd/vpn_switch.conf.in \
	    > $(DESTDIR)$(DEVDDIR)/vpn_switch.conf
	@chmod 644 $(DESTDIR)$(DEVDDIR)/vpn_switch.conf
	@if [ -f $(DESTDIR)$(RCCONFDIR)/vpn_switch ]; then \
	    echo "  → FreeBSD: kept existing $(RCCONFDIR)/vpn_switch"; \
	else \
	    printf '# written by gmake install (%s); edit freely, reinstalls keep this file\n' "$$(date +%Y-%m-%d)" \
	        > $(DESTDIR)$(RCCONFDIR)/vpn_switch; \
	    printf 'vpn_switch_user="%s"\nvpn_switch_base="%s"\nvpn_switch_ifname="%s"\n' \
	        "$(VPN_SWITCH_RC_USER)" "$(VPN_SWITCH_RC_BASE)" "$(VPN_SWITCH_RC_IFNAME)" \
	        >> $(DESTDIR)$(RCCONFDIR)/vpn_switch; \
	    chmod 644 $(DESTDIR)$(RCCONFDIR)/vpn_switch; \
	    echo "  → FreeBSD: wrote $(RCCONFDIR)/vpn_switch (user=$(VPN_SWITCH_RC_USER) base=$(VPN_SWITCH_RC_BASE) ifname=$(VPN_SWITCH_RC_IFNAME))"; \
	fi
	@echo "  → FreeBSD: installed rc.d service script and devd rule ($(DEVDDIR)/vpn_switch.conf)"
	@echo "  → enable with: sysrc vpn_switch_enable=YES; service devd restart"
	@echo "    (the user needs passwordless sudo for the connect steps: docs/TUTORIAL_SUDO.md)"

uninstall-platform:
	@rm -f $(DESTDIR)$(RCDIR)/vpn_switch $(DESTDIR)$(DEVDDIR)/vpn_switch.conf
	@echo "  → FreeBSD: removed rc.d service script and devd rule (kept $(RCCONFDIR)/vpn_switch)"
