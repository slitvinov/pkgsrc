$NetBSD$

On macOS with pkgsrc's libffi (not the SDK one, so FFI_AVAILABLE_APPLE
is undefined) use ffi_closure_alloc() and ffi_prep_closure_loc() too.
Otherwise cffi falls back to its own allocator that maps memory
writable and executable, which arm64 macOS refuses: every
ffi.callback() raised MemoryError "Cannot allocate write+execute memory".

--- src/c/_cffi_backend.c.orig
+++ src/c/_cffi_backend.c
@@ -117,6 +117,17 @@
 # define CFFI_CHECK_FFI_PREP_CIF_VAR __builtin_available(macos 10.15, ios 13, watchos 6, tvos 13, *)
 # define CFFI_CHECK_FFI_PREP_CIF_VAR_MAYBE 1
 
+#elif defined(__APPLE__) && !defined(FFI_AVAILABLE_APPLE)
+
+/* pkgsrc: upstream libffi instead of the SDK's; it always has the
+   closure API, and on arm64 its closures use trampoline tables. */
+# define CFFI_CHECK_FFI_CLOSURE_ALLOC 1
+# define CFFI_CHECK_FFI_CLOSURE_ALLOC_MAYBE 1
+# define CFFI_CHECK_FFI_PREP_CLOSURE_LOC 1
+# define CFFI_CHECK_FFI_PREP_CLOSURE_LOC_MAYBE 1
+# define CFFI_CHECK_FFI_PREP_CIF_VAR 1
+# define CFFI_CHECK_FFI_PREP_CIF_VAR_MAYBE 1
+
 #elif defined(__EMSCRIPTEN__)
 
 # define CFFI_CHECK_FFI_CLOSURE_ALLOC 1
