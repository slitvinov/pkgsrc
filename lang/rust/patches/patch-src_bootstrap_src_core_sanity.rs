$NetBSD: patch-src_bootstrap_src_core_sanity.rs,v 1.4 2026/09/30 20:01:29 wiz Exp $

Add m68k-unknown-netbsd to "missing stage0" list.

--- src/bootstrap/src/core/sanity.rs.orig
+++ src/bootstrap/src/core/sanity.rs
@@ -36,6 +36,7 @@
 const STAGE0_MISSING_TARGETS: &[&str] = &[
     // just a dummy comment so the list doesn't get onelined
     "aarch64-unknown-l4re-uclibc",
+    "m68k-unknown-netbsd",
 ];
 
 /// Minimum version threshold for libstdc++ required when using prebuilt LLVM
@@ -264,7 +265,10 @@
                 for duplicated_target in duplicated_targets {
                     println!("  {duplicated_target}");
                 }
-                std::process::exit(1);
+// For now don't make this a fatal error.
+// e.g. m68k-unknown-netbsd may be in the list for a while
+// until LLVM is fixed to not emit 16-bit PC-relative relocations only...
+//              std::process::exit(1);
             }
 
             // Check if it's a built-in target.
