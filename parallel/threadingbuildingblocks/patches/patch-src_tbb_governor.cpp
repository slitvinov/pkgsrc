$NetBSD$

Release the global_control storage before unloading the dynamically
loaded tbbmalloc: it is freed through cache_aligned_deallocate(), which
then points into the unloaded library. Fixes a segfault at exit on Darwin
(e.g. oiiotool --version, Blender makesdna).

--- src/tbb/governor.cpp.orig
+++ src/tbb/governor.cpp
@@ -119,8 +119,11 @@
 #endif /* TBB_USE_ASSERT */
 
     system_topology::destroy();
-    dynamic_unlink_all();
+    // pkgsrc: release the global_control storage before unloading tbbmalloc:
+    // it is freed with cache_aligned_deallocate(), which may point into the
+    // dynamically loaded tbbmalloc (crash at exit on Darwin otherwise).
     global_control_release();
+    dynamic_unlink_all();
 }
 
 rml::tbb_server* governor::create_rml_server ( rml::tbb_client& client ) {
