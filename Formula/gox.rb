class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.8/gox_0.1.8_darwin_amd64.tar.gz"
      sha256 "c0ee27b6dedf34d88d046b03f329eb13367787f97f6b98d430a62a8904a4ea52"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.8/gox_0.1.8_darwin_arm64.tar.gz"
      sha256 "cc98e8f800b62ece9d6b67fb00ad35331a27134b894fe30ed10bc9e0b00f1f4b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.8/gox_0.1.8_linux_amd64.tar.gz"
      sha256 "5367a2d13a10d219c52412d4624aeb01f0905e63d4df073008da5bdde326fd77"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.8/gox_0.1.8_linux_arm64.tar.gz"
      sha256 "f37c1c88c8044747501b8fe94f48a40a70de2135fbc5345667af259f579f2f1d"
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
