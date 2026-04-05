class Mindvault < Formula
  desc "Local-first second brain — chat with your own knowledge"
  homepage "https://github.com/calebthecm/MindVault"
  url "https://github.com/calebthecm/MindVault/archive/refs/tags/v0.5.465.tar.gz"
  sha256 "c21663b0ec0a4792a9756fc16d57c019d79bca2541576e672fdb08dc73f142fe"
  license "MIT"
  version "0.5.465"

  depends_on "python@3.12"

  def install
    # Use python -m venv directly — includes pip by default,
    # unlike Homebrew's virtualenv_create which uses --without-pip
    # and can fail to bootstrap pip on some systems.
    python = Formula["python@3.12"].opt_bin/"python3.12"
    system python, "-m", "venv", libexec
    system libexec/"bin/pip3", "install", "."
    bin.install_symlink libexec/"bin/mindvault"
  end

  def caveats
    <<~EOS
      MindVault stores your brain data in ~/.mindvault/

      To get started:
        mindvault setup

      For local LLM support, install Ollama first:
        brew install ollama
        ollama pull nomic-embed-text
        ollama pull llama3.2
    EOS
  end

  test do
    assert_match "mindvault", shell_output("#{bin}/mindvault --help 2>&1", 0)
  end
end
