class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.6/gox_0.1.6_darwin_amd64.tar.gz"
      sha256 "f42515a09bced2cf64d0dd6c46c749c20f2d8d7a49cb9fe1b3e644feb0edd161"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.6/gox_0.1.6_darwin_arm64.tar.gz"
      sha256 "9827e5d98ec68619f4af2199f4a2fc0d9720c1dec72f7f9dd3a58fc4185b02dc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.6/gox_0.1.6_linux_amd64.tar.gz"
      sha256 "4eaafdba11da07e79dfa49187b08b969cbfb8926f3906b05b0df14e6c3f368b7"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.6/gox_0.1.6_linux_arm64.tar.gz"
      sha256 "076c3187715dd4345ca6b86580f52c95bce15d18e028d476a4119e1df20add25"
    end
  end

  def install
    libexec.install "gox"
    (bin/"gox").write <<~SH
      #!/bin/sh
      if [ "${1:-}" = update ]; then
        echo 'This GOX installation is managed by Homebrew.' >&2
        echo 'Run: brew update && brew upgrade gox-lang/tap/gox' >&2
        exit 1
      fi
      export GOX_LSP_AUTO_UPDATE=0
      exec "#{libexec}/gox" "$@"
    SH
  end

  def caveats
    <<~EOS
      Update GOX with brew update && brew upgrade gox-lang/tap/gox.
      GOX downloads its Go and frontend toolchains when needed.
      Running projects requires a C compiler: Xcode Command Line Tools on
      macOS, or GCC and development headers on Linux.
    EOS
  end

  test do
    assert_match "GOX Server v#{version}", shell_output("#{bin}/gox version")
    assert_match "brew upgrade gox-lang/tap/gox", shell_output("#{bin}/gox update 2>&1", 1)
  end
end
