class Mapdiff < Formula
  desc "Review a change on a map of your code: diffs by function and type, drawn with what they touch"
  homepage "https://avgvi.github.io/mapdiff/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.1.0/mapdiff-aarch64-apple-darwin.tar.xz"
      sha256 "bf2647135d45eb3a2c8116551f28782c7cf34f8c9575de79c6ed8a7775eb27eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.1.0/mapdiff-x86_64-apple-darwin.tar.xz"
      sha256 "6bdc855f73d6767312f87c1f39d0503991993ddfac687dd1d4c1662cab678720"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.1.0/mapdiff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3023f569e511ed58bd10fed1bbde1352b46d3c2a9618a3d3d3edc5a31e784429"
    end
    if Hardware::CPU.intel?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.1.0/mapdiff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d805ffe4fd5a11feecc9b8b56baef9caf130ec7cfcb32256fec1b7e8a33526c"
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
      bin.install "mapdiff"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mapdiff"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mapdiff"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mapdiff"
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
