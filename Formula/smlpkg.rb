class Smlpkg < Formula
  desc "Package manager for Standard ML libraries and programs"
  homepage "https://github.com/diku-dk/smlpkg"
  url "https://github.com/diku-dk/smlpkg/archive/v0.1.3.tar.gz"
  sha256 "cfa7eeff951e04df428694fda38917ee2aaaf0532e2d1dbea7ab4c150f4fe2f0"
  head "https://github.com/diku-dk/smlpkg.git"

  depends_on "mlkit"

  def install
    system "make", "-C", "src", "smlpkg"
    system "make", "install", "INSTALLDIR=#{bin}"
  end

  test do
    expected_pkg = <<~EOS
      package github.com/diku-dk/testpkg

      require {
        github.com/diku-dk/sml-random 0.1.0 #8b329d10b0df570da087f9e15f3c829c9a1d74c2
      }
    EOS
    system bin/"smlpkg", "init", "github.com/diku-dk/testpkg"
    system bin/"smlpkg", "add", "github.com/diku-dk/sml-random", "0.1.0"
    assert_equal expected_pkg, (testpath/"sml.pkg").read
  end
end
