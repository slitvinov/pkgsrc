# $NetBSD: Makefile,v 1.47 2026/08/24 08:42:30 adam Exp $

DISTNAME=		clucene-core-2.3.3.4
PKGNAME=		lib${DISTNAME:S/-core-/-/}
PKGREVISION=		32
CATEGORIES=		textproc
MASTER_SITES=		${MASTER_SITE_SOURCEFORGE:=clucene/}

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		https://clucene.sourceforge.net/index.php/Main_Page
COMMENT=		Text search engine written in C++
LICENSE=		gnu-lgpl-v2.1 OR apache-2.0

PKGCONFIG_OVERRIDE+=	libclucene-core.pc.in

USE_LANGUAGES=	c c++
USE_LIBTOOL=	yes

CMAKE_CONFIGURE_ARGS+=	-DBUILD_CONTRIBS_LIB=ON
# https://sourceforge.net/p/clucene/bugs/236/
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_POLICY_VERSION_MINIMUM=3.5

.include "../../mk/bsd.prefs.mk"

# The macOS SDK no longer declares stat64 and friends, but they still
# link, so the configure checks pick them.
.if ${OPSYS} == "Darwin"
CMAKE_CONFIGURE_ARGS+=	-D_CL_HAVE_FUNCTION_FSTAT64:INTERNAL=
CMAKE_CONFIGURE_ARGS+=	-D_CL_HAVE_FUNCTION_STAT64:INTERNAL=
CMAKE_CONFIGURE_ARGS+=	-D_CL_HAVE_FUNCTION_LSEEK64:INTERNAL=
.endif

.include "../../devel/cmake/build.mk"
.include "../../devel/boost-libs/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
