class Mindvault < Formula
  include Language::Python::Virtualenv

  desc "Local-first second brain — chat with your own knowledge"
  homepage "https://github.com/calebthecm/MindVault"
  url "https://github.com/calebthecm/MindVault/archive/refs/tags/v0.5.460.tar.gz"
  sha256 "a1a3cdd019cc1fae1fca63ce7e62c99cf529862993a5d15425aeceaa75f02865"
  license "Source-Available"
  version "0.5.460"

  depends_on "python@3.12"

  def install
    # Use system pip directly to avoid Homebrew's --uploaded-prior-to
    # timestamp restriction, which blocks packages uploaded after the
    # source tarball was created.
    venv = virtualenv_create(libexec, "python3.12")
    system libexec/"bin/pip", "install", "mindvault==#{version}"
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
