# The FreeBSD port of vpn-switch. The checkout is the source: elebake stage
# rescue tool package writes the distfile as a git archive of the checkout
# (<name>-<version>.tar.gz into DISTDIR, VERSION substituted on the way
# out) and runs 'make makesum package' here with ELEBAKE_DISTVERSION in the environment, DISTDIR,
# WRKDIRPREFIX and PACKAGES of the stage. On the way to the ports tree the
# same file takes MASTER_SITES (or USE_GITHUB) and a committed distinfo.
PORTNAME=	vpn-switch
DISTVERSION=	${ELEBAKE_DISTVERSION:U0.0.0}	# from the environment: a command-line variable would travel in MAKEFLAGS into the dependency ports
CATEGORIES=	net
MASTER_SITES=	# the distfile is placed into DISTDIR by the build

MAINTAINER=	dr.johannes.bruegmann@gmail.com
COMMENT=	Switch between WireGuard and OpenVPN sessions with pf and DNS phases
WWW=		https://github.com/enk-ode/vpn-switch

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	wg:net/wireguard-tools \
		openvpn:security/openvpn \
		gpg:security/gnupg

USES=		gmake
NO_BUILD=	yes
NO_ARCH=	yes

# The checkout's GNUmakefile knows the layout (install: the tool under
# lib/vpn-switch, the wrapper in bin, the rc.d script, the manual, the docs);
# the plist is read from what it staged.
do-install:
	@cd ${WRKSRC} && ${GMAKE} install DESTDIR=${STAGEDIR} PREFIX=${PREFIX}

post-install:
	@cd ${STAGEDIR}${PREFIX} && ${FIND} . \( -type f -o -type l \) | ${SED} -e 's|^\./||' -e 's|^\(share/man/man[1-9]/.*\.[1-9]\)$$|\1.gz|' | ${SORT} >> ${TMPPLIST}

.include <bsd.port.mk>
