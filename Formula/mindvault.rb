class Mindvault < Formula
  desc "Local-first second brain — chat with your own knowledge"
  homepage "https://github.com/calebthecm/MindVault"
  url "https://github.com/calebthecm/MindVault/archive/refs/tags/main.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "Source-Available"
  version "main"

  depends_on "python@3.12"

  def install
    # Install into an isolated virtualenv, pulling deps from PyPI
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install "mindvault==#{version}"
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
