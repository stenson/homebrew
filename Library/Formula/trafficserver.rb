class Trafficserver < Formula
  homepage "http://trafficserver.apache.org/"
  url "http://www.apache.org/dyn/closer.cgi?path=trafficserver/trafficserver-5.2.0.tar.bz2"
  mirror "https://archive.apache.org/dist/trafficserver/trafficserver-5.2.0.tar.bz2"
  sha1 "a32ae5a0ea6d734a955fa56f3e446a66c08be21f"

  bottle do
    sha256 "60ca4def066dd106a5f71706b3b07d7ee8d093f95926d341f4d98bd88c3b4d2d" => :yosemite
    sha256 "25134b656b86365d4c7d43de3038f71e864dfb50c6895f94b3c3b035c3f85986" => :mavericks
    sha256 "4920a708ef78452027f9a258f50b7802b3f0bdc68aca92337d2468d9abe88415" => :mountain_lion
  end

  depends_on "openssl"
  depends_on "pcre"

  # remove some amd64 compiler options that fail on Snow Leopard
  patch :DATA if MacOS.version == :snow_leopard

  def install
    # Needed for correct ./configure detections.
    ENV.enable_warnings
    # Needed for OpenSSL headers on Lion.
    ENV.append_to_cflags "-Wno-deprecated-declarations"
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-user=#{ENV["USER"]}",
                          "--with-group=admin"
    system "make", "install"
  end

  test do
    system "#{bin}/trafficserver", "status"
  end
end

__END__
diff --git a/configure b/configure
index 49add2a..e478b34 100755
--- a/configure
+++ b/configure
@@ -24109,48 +24109,6 @@ $as_echo "yes" >&6; }

 else

-
-  if test "x$CXXFLAGS" = "x"; then
-    test "x$verbose" = "xyes" && echo "  setting CXXFLAGS to \"-mcx16\""
-    CXXFLAGS="-mcx16"
-  else
-    ats_addto_bugger="-mcx16"
-    for i in $ats_addto_bugger; do
-      ats_addto_duplicate="0"
-      for j in $CXXFLAGS; do
-        if test "x$i" = "x$j"; then
-          ats_addto_duplicate="1"
-          break
-        fi
-      done
-      if test $ats_addto_duplicate = "0"; then
-        test "x$verbose" = "xyes" && echo "  adding \"$i\" to CXXFLAGS"
-        CXXFLAGS="$CXXFLAGS $i"
-      fi
-    done
-  fi
-
-
-  if test "x$CFLAGS" = "x"; then
-    test "x$verbose" = "xyes" && echo "  setting CFLAGS to \"-mcx16\""
-    CFLAGS="-mcx16"
-  else
-    ats_addto_bugger="-mcx16"
-    for i in $ats_addto_bugger; do
-      ats_addto_duplicate="0"
-      for j in $CFLAGS; do
-        if test "x$i" = "x$j"; then
-          ats_addto_duplicate="1"
-          break
-        fi
-      done
-      if test $ats_addto_duplicate = "0"; then
-        test "x$verbose" = "xyes" && echo "  adding \"$i\" to CFLAGS"
-        CFLAGS="$CFLAGS $i"
-      fi
-    done
-  fi
-
     ats_save_CFLAGS=$CFLAGS
  CFLAGS="$CFLAGS $CFLAGS_WARN"
  if test "$ac_cv_c_compiler_gnu" = "yes"; then
@@ -24204,52 +24162,6 @@ ac_compiler_gnu=$ac_cv_c_compiler_gnu



-if test "x$has_128bit_cas" = "x1"; then :
-
-
-  if test "x$CFLAGS" = "x"; then
-    test "x$verbose" = "xyes" && echo "  setting CFLAGS to \"-mcx16\""
-    CFLAGS="-mcx16"
-  else
-    ats_addto_bugger="-mcx16"
-    for i in $ats_addto_bugger; do
-      ats_addto_duplicate="0"
-      for j in $CFLAGS; do
-        if test "x$i" = "x$j"; then
-          ats_addto_duplicate="1"
-          break
-        fi
-      done
-      if test $ats_addto_duplicate = "0"; then
-        test "x$verbose" = "xyes" && echo "  adding \"$i\" to CFLAGS"
-        CFLAGS="$CFLAGS $i"
-      fi
-    done
-  fi
-
-
-  if test "x$CXXFLAGS" = "x"; then
-    test "x$verbose" = "xyes" && echo "  setting CXXFLAGS to \"-mcx16\""
-    CXXFLAGS="-mcx16"
-  else
-    ats_addto_bugger="-mcx16"
-    for i in $ats_addto_bugger; do
-      ats_addto_duplicate="0"
-      for j in $CXXFLAGS; do
-        if test "x$i" = "x$j"; then
-          ats_addto_duplicate="1"
-          break
-        fi
-      done
-      if test $ats_addto_duplicate = "0"; then
-        test "x$verbose" = "xyes" && echo "  adding \"$i\" to CXXFLAGS"
-        CXXFLAGS="$CXXFLAGS $i"
-      fi
-    done
-  fi
-
-
-fi

 # Check for POSIX capabilities library.
 # If we don't find it, disable checking for header.
