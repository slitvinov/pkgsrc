$NetBSD: patch-external_pdfium_Library__pdfium.mk,v 1.5 2026/02/09 16:59:59 ryoon Exp $

We also want to link against librt on Solaris and BSD.

Link the system openjpeg2 and abseil on every OS, not only in the
Linux branch: on Darwin pdfium is built with USE_SYSTEM_LIBOPENJPEG2
but was not linked with -lopenjp2.

--- external/pdfium/Library_pdfium.mk.orig
+++ external/pdfium/Library_pdfium.mk
@@ -577,12 +577,6 @@
     icuuc \
 ))
 
-ifneq (,$(filter LINUX ANDROID,$(OS)))
-$(eval $(call gb_Library_add_libs,pdfium,\
-    -ldl \
-    -lrt \
-))
-
 ifeq ($(SYSTEM_OPENJPEG2),TRUE)
 $(eval $(call gb_Library_add_libs,pdfium,\
     $(OPENJPEG2_LIBS) \
@@ -595,6 +589,17 @@
 ))
 endif
 
+ifneq (,$(filter LINUX ANDROID,$(OS)))
+$(eval $(call gb_Library_add_libs,pdfium,\
+    -ldl \
+))
+endif
+
+ifeq ($(OS), $(filter LINUX %BSD SOLARIS ANDROID, $(OS)))
+$(eval $(call gb_Library_add_libs,pdfium,\
+    -lrt \
+))
+
 $(eval $(call gb_Library_use_external,pdfium,freetype))
 $(eval $(call gb_Library_add_defs,pdfium,\
     -DDEFINE_PS_TABLES_DATA \
@@ -713,7 +718,7 @@
 ))
 endif
 
-ifneq (,$(filter LINUX FREEBSD OPENBSD,$(OS)))
+ifneq (,$(filter LINUX %BSD SOLARIS,$(OS)))
 # fxge
 $(eval $(call gb_Library_add_generated_exception_objects,pdfium,\
     UnpackedTarball/pdfium/core/fxge/linux/fx_linux_impl \
