class Hopback < Formula
  desc "Find, resume and fork coding-agent sessions across Claude Code, Codex and more"
  homepage "https://github.com/avgvi/hopback"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/avgvi/hopback/releases/download/v0.2.0/hopback-aarch64-apple-darwin.tar.xz"
      sha256 "710f02543a314d02ea575c9a1d5f79ee3d3d3414d2b123e2581b97570cfa5c3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/avgvi/hopback/releases/download/v0.2.0/hopback-x86_64-apple-darwin.tar.xz"
      sha256 "06832a79707047285cb2716e0336041d4667d41d3e60e85c4298a378c3bfae0d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/avgvi/hopback/releases/download/v0.2.0/hopback-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e56aaabdd704be24c546d5ae88e498b64681a107adecdae6d6d36bcb178f3331"
    end
    if Hardware::CPU.intel?
      url "https://github.com/avgvi/hopback/releases/download/v0.2.0/hopback-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef4e26091c7d6a9a4c6372a6b11eada81f7655224d5397a06b4a8475a5f69f4c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hb", "hopback"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hb", "hopback"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hb", "hopback"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hb", "hopback"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
