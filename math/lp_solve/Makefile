# $NetBSD: Makefile,v 1.15 2025/11/17 11:01:07 wiz Exp $
#

DISTNAME=	lp_solve_5.5.2.3_source
PKGNAME=	${DISTNAME:S/_source//:S/_5/-5/}
PKGREVISION=	1
CATEGORIES=	math devel
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=lpsolve/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://lpsolve.sourceforge.net/
COMMENT=	Mixed Integer Linear Programming (MILP) solver
#LICENSE=	LGPL, unclear which version (see lp_lib.h)

USE_GCC_RUNTIME=	yes

WRKSRC=		${WRKDIR}/lp_solve_5.5

SUBST_CLASSES+=		dl
SUBST_STAGE.dl=		pre-build
SUBST_SED.dl+=		-e s,-ldl,${DL_LIBS:Q},g
SUBST_SED.dl+=		-e s,^opts=.*,opts=\'${CFLAGS:Q}\',g
SUBST_SED.dl+=		-e s,-fpic,-fPIC,g
SUBST_VARS.dl+=		WRKDIR
SUBST_FILES.dl+=	lp_solve/ccc
SUBST_FILES.dl+=	lpsolve55/ccc
SUBST_FILES.dl+=	demo/ccc

.include "../../mk/bsd.fast.prefs.mk"

.if ${MACHINE_ARCH} == "alpha" || ${MACHINE_ARCH} == "sparc64" || \
	${MACHINE_ARCH} == "x86_64" || ${MACHINE_CPU} == "aarch64"
LPSOLVE_ARCH=	ux64
.else
LPSOLVE_ARCH=	ux32
.endif

INSTALLATION_DIRS=	bin include/lpsolve lib

PLIST_VARS+=	dylib so
.if ${OPSYS} == "Darwin"
PLIST.dylib=	yes
.else
PLIST.so=	yes
.endif

MAKE_ENV+=	DL_LDADD=${BUILDLINK_LDADD.dl:Q}

do-build:
.for dir in lp_solve lpsolve55 demo
	${RUN}${_ULIMIT_CMD}				\
	cd ${WRKSRC}/${dir} &&				\
	${SETENV} ${MAKE_ENV} ${SH} ccc
.endfor
.if ${OPSYS} == "Darwin"
	cd ${WRKSRC}/lpsolve55/bin/${LPSOLVE_ARCH} &&			\
	${CC} -dynamiclib -install_name ${PREFIX}/lib/liblpsolve55.dylib	\
		-o liblpsolve55.dylib -Wl,-all_load liblpsolve55.a	\
		${LDFLAGS} -lm
.endif

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/lp_solve/bin/${LPSOLVE_ARCH}/lp_solve \
		${DESTDIR}${PREFIX}/bin
.for i in declare.h fortify.h ini.h lp_*.h lpkit.h lpsolve.h ufortify.h yacc_read.h
	${INSTALL_DATA} ${WRKSRC}/${i} ${DESTDIR}${PREFIX}/include/lpsolve
.endfor
	${INSTALL_LIB} ${WRKSRC}/lpsolve55/bin/${LPSOLVE_ARCH}/liblpsolve55.a \
		${DESTDIR}${PREFIX}/lib
.if ${OPSYS} == "Darwin"
	${INSTALL_LIB} ${WRKSRC}/lpsolve55/bin/${LPSOLVE_ARCH}/liblpsolve55.dylib \
		${DESTDIR}${PREFIX}/lib
.else
	${INSTALL_LIB} ${WRKSRC}/lpsolve55/bin/${LPSOLVE_ARCH}/liblpsolve55.so \
		${DESTDIR}${PREFIX}/lib
	${LN} -sf liblpsolve55.so ${DESTDIR}${PREFIX}/lib/liblpsolve55.so.1
.endif

.include "../../mk/dlopen.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
