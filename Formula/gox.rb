class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.10"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.10/gox_0.1.10_darwin_amd64.tar.gz"
      sha256 "1cb8de209a057fa8ea7145cf06130eb41540f01ad6ad0d08c7cb5f7c0d637670"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.10/gox_0.1.10_darwin_arm64.tar.gz"
      sha256 "8839f6c4f3bae864b462e3614be428a706c0139d753a0eb23ac35af9382cf563"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.10/gox_0.1.10_linux_amd64.tar.gz"
      sha256 "89dbfbe1cc07faedba60ac7b76e8f14a5c018fb5fa20d70638258d842c0144a6"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.10/gox_0.1.10_linux_arm64.tar.gz"
      sha256 "49a62519cc51b6e52ec207727403de81b70b41928ecc48f718ce22a66578d8f3"
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
