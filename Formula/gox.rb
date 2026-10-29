class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.9"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.9/gox_0.1.9_darwin_amd64.tar.gz"
      sha256 "915ef734f7fe2629221704d1b1be1302a40def799ee5b09e21449aacdea3537a"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.9/gox_0.1.9_darwin_arm64.tar.gz"
      sha256 "8a2deb6705ceb61b2d5481042dd1b5a4f3a96da522bcdaa4bbe840696443ba0e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.9/gox_0.1.9_linux_amd64.tar.gz"
      sha256 "8ed19090d970d6fb49d46c48e074a6740329ce4e46fd64870598478ac7a85f8c"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.9/gox_0.1.9_linux_arm64.tar.gz"
      sha256 "801dc54abedcfaa81ba2027ab2047a1588c4c461d5aafc898adaf2ad790b002f"
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
