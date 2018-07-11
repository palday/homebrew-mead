# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula

class Mdwc < Formula
  desc "Word count utility for Markdown files with pandoc-style YAML block"
  homepage "https://gitlab.com/palday/mdwc/"
  url "https://gitlab.com/palday/mdwc/repository/archive.tar.bz2?ref=v1.1"
  version "1.1"
  sha256 "6c597ea7ba36a66d7528f9d90eaed95b476af555c9b4a7ba7a3fd7f82f522fc2"

  depends_on "gnu-getopt"
  depends_on "coreutils"
  depends_on "bash" => :recommended
  # this patch creates an alias to GNU getopt, which is a keg-only dependency and the
  # autolinking portion doesn't seem to work for bash scripts
  patch :DATA

  def install
    inreplace "mdwc", "mktemp", "gmktemp"
    inreplace "mdwc", "wc", "gwc"
    bin.install "mdwc"
  end

  test do
    system "mdwc -h"
  end
end

__END__
diff --git a/mdwc b/mdwc
index f2a9cbe..86358c9 100755
--- a/mdwc
+++ b/mdwc
@@ -17,6 +17,9 @@

 # argument parsing adapted from http://stackoverflow.com/a/29754866/2022326

+shopt -s expand_aliases
+alias getopt="HOMEBREW_PREFIX/Cellar/gnu-getopt/$(ls HOMEBREW_PREFIX/Cellar/gnu-getopt | tail -n1)/bin/getopt"
+
 getopt --test > /dev/null
 if [[ $? != 4 ]]; then
     echo "I'm sorry, 'getopt --test' failed in this environment."
