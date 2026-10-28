class Gox < Formula
  desc "Web framework and development tools for Go"
  homepage "https://gox-lang.dev"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.5/gox_0.1.5_darwin_amd64.tar.gz"
      sha256 "68ec41e92654eadde053ea79ee508e10bc63a00d4b19c77b843a02b75321b282"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.5/gox_0.1.5_darwin_arm64.tar.gz"
      sha256 "fd43cfab7943b3f0b17328ae756cdfa6bb2e56229108ff44593581779a0a4f3a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gox-lang/server/releases/download/v0.1.5/gox_0.1.5_linux_amd64.tar.gz"
      sha256 "65070e744688ad699444f905e4989a2e80ef6ca519f5ae707335e6e41db17fcf"
    end
    on_arm do
      url "https://github.com/gox-lang/server/releases/download/v0.1.5/gox_0.1.5_linux_arm64.tar.gz"
      sha256 "0aaa759b46714beed3d7734bce254d826131b9aeb516c300067193b70b30d5b4"
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
