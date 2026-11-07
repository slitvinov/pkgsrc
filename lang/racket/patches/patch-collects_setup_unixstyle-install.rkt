$NetBSD$

Add PREFIX/lib to lib-search-dirs in the generated config.rktd, so
that ffi-lib finds pkgsrc libraries such as OpenSSL.  On macOS, Racket
otherwise falls back to the unversioned /usr/lib/libssl.dylib, which
aborts the process, so raco pkg install over HTTPS crashed.

--- collects/setup/unixstyle-install.rkt.orig
+++ collects/setup/unixstyle-install.rkt
@@ -480,6 +480,9 @@
            (when link-shared? ; never true for now
              (out! 'dll-dir (dir: 'lib)))
            (out! 'lib-dir (dir: 'librkt))
+           ;; pkgsrc: let ffi-lib find libraries such as libssl and
+           ;; libcrypto in PREFIX/lib, instead of the system's.
+           (out! 'lib-search-dirs (list #f (dir: 'lib)))
            (out! 'pkgs-dir (dir: 'pkgs))
            (out! 'share-dir (dir: 'sharerkt))
            (out! 'include-dir (dir: 'includerkt))
