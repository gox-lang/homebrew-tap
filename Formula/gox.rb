class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.7/gox_0.1.7_darwin_amd64.tar.gz"
      sha256 "d203e59650e74a2829ce02b6f1ebde2302eba62a9b597e277b3c8d5bf4e6f8d1"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.7/gox_0.1.7_darwin_arm64.tar.gz"
      sha256 "b306a81cd4336b36c9df3e25dcc5ff5dbe6df70c60ae80d44b6a2436bf5d4d59"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.7/gox_0.1.7_linux_amd64.tar.gz"
      sha256 "c749a44d2effb42ca98d893af6751a056e71b25b221430942f12f51912bbec42"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.7/gox_0.1.7_linux_arm64.tar.gz"
      sha256 "e6d9bbd7b6f8732512df7e1cbb81e04448a70252a0260f3a62907b7de1be6234"
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
