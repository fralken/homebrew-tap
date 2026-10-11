class Gatir < Formula
  desc "Authenticating proxy for corporate proxies (NTLM, Kerberos)"
  homepage "https://github.com/fralken/gatir"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/fralken/gatir/releases/download/v0.2.0/gatir-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "6639173545bcf924cce25e9552b6d90a382c0b98850ccd2e5318ca691c64d57d"
    end

    on_intel do
      url "https://github.com/fralken/gatir/releases/download/v0.2.0/gatir-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "3fa5e4c113ebb994422b1961bdfd6c5b59408c0e6e47f3c196f0b05eac6ae3d3"
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
