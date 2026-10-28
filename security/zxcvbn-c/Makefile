# $NetBSD: Makefile,v 1.3 2025/09/22 22:33:44 ryoon Exp $

DISTNAME=	zxcvbn-c-2.6
CATEGORIES=	security
MASTER_SITES=	${MASTER_SITE_GITHUB:=tsyrogit/}
GITHUB_PROJECT=	zxcvbn-c
GITHUB_TAG=	v${PKGVERSION_NOREV}
PKGREVISION=	1

MAINTAINER=	ryoon@NetBSD.org
HOMEPAGE=	https://github.com/tsyrogit/zxcvbn-c/
COMMENT=	Password strength estimator
LICENSE=	mit

MAKE_JOBS_SAFE=	no

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++11

INSTALLATION_DIRS+=	include lib

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_WITH_INSTALL_NAME_DIR:BOOL=ON

.include "../../mk/bsd.prefs.mk"

PLIST_VARS+=	dylib so
.if ${OPSYS} == "Darwin"
ZXCVBN_LIB=	libzxcvbn.0.dylib
ZXCVBN_LINK=	libzxcvbn.dylib
PLIST.dylib=	yes
.else
ZXCVBN_LIB=	libzxcvbn.so.0
ZXCVBN_LINK=	libzxcvbn.so
PLIST.so=	yes
.endif

do-install:
	${INSTALL_DATA} ${WRKSRC}/zxcvbn.h ${DESTDIR}${PREFIX}/include
	${INSTALL_LIB} ${WRKSRC}/${CMAKE_BUILD_DIR}/${ZXCVBN_LIB} ${DESTDIR}${PREFIX}/lib
	cd ${DESTDIR}${PREFIX}/lib && ${LN} -s ${ZXCVBN_LIB} ${ZXCVBN_LINK}

.include "../../devel/cmake/build.mk"
.include "../../mk/bsd.pkg.mk"
