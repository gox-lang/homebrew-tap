class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.3/gox_0.1.3_darwin_amd64.tar.gz"
      sha256 "34d3ff4d7a4b870261b0f6924ad423bf666c0a93c9ddb5a93753ac305ff42971"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.3/gox_0.1.3_darwin_arm64.tar.gz"
      sha256 "5b132f68e6518a879771dfd794b34c9fcfa2caacd9cfa24fefc2e0cd64514dcd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.3/gox_0.1.3_linux_amd64.tar.gz"
      sha256 "e2e76309199ddb536dfc9de4f5620b12cb0d4494ef6ab803f90ac5b9925ed959"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.3/gox_0.1.3_linux_arm64.tar.gz"
      sha256 "22bfabe4ebf8c17456771e5dca943d111333f9da43b7e7cf77ca153607bb2739"
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
