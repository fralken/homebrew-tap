class Gatir < Formula
  desc "Authenticating proxy for corporate proxies (NTLM, Kerberos)"
  homepage "https://github.com/fralken/gatir"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/fralken/gatir/releases/download/v0.1.0/gatir-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "26b8e9f81776207bf8514e112316dd7b8abcc930dc9a91b92cc19b198ea0ea3f"
    end

    on_intel do
      url "https://github.com/fralken/gatir/releases/download/v0.1.0/gatir-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "1400407ed40e6bea5d6b91b368f0b9d8104405993fb66081b2deed879fe271b7"
    end
  end

  def install
    bin.install "gatir"
    man1.install Dir["man/man1/*"]
    doc.install "README.md", "gatir.example.toml"
    doc.install Dir["docs/*"]
  end

  def caveats
    <<~EOS
      gatir needs a configuration file before it can run:
        mkdir -p ~/.config/gatir
        cp #{doc}/gatir.example.toml ~/.config/gatir/gatir.toml
        chmod 600 ~/.config/gatir/gatir.toml
      Edit it, then check it with:
        gatir config check
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gatir --version")
  end
end
