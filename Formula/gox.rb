class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.4/gox_0.1.4_darwin_amd64.tar.gz"
      sha256 "7bd51758c1efbf104c175a2c3b404cd3ab1344b622e3447a42d530b43a7508a0"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.4/gox_0.1.4_darwin_arm64.tar.gz"
      sha256 "5454890cd61ecd524698c50f85db88a1cdd6d301ef56efed3f05d38187bce56d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.4/gox_0.1.4_linux_amd64.tar.gz"
      sha256 "f8512ebf3ccfcec80958a94fba231525ec2dc343a8c4edcc4ad8846377e056c1"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.4/gox_0.1.4_linux_arm64.tar.gz"
      sha256 "05f991dc15564f25d25eee8ef7ef3feddc542084a5cb3a3a06c543ed3c195ece"
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
