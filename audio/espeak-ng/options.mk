# $NetBSD: options.mk,v 1.1 2024/03/11 08:03:45 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.espeak-ng
PKG_SUPPORTED_OPTIONS+=	mbrola sonic
PKG_SUGGESTED_OPTIONS+=	sonic

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Msonic)
.  include "../../audio/sonic/buildlink3.mk"
CONFIGURE_ARGS+=	--with-sonic
.else
CONFIGURE_ARGS+=	--without-sonic
.endif

# The MBROLA support is always built; the mb-* voices only need the
# synthesizer at run time.  It is AGPL, which is not accepted by
# default, so it is not suggested.
.if !empty(PKG_OPTIONS:Mmbrola)
DEPENDS+=	mbrola-[0-9]*:../../audio/mbrola
.endif
