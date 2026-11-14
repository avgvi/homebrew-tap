class Mapdiff < Formula
  desc "Review a change on a map of your code: diffs by function and type, drawn with what they touch"
  homepage "https://avgvi.github.io/mapdiff/"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.2.0/mapdiff-aarch64-apple-darwin.tar.xz"
      sha256 "77aa15136cbf6e1ddb15ee127d3835e4a74fc29a1a9c73020d10863e5344a2fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.2.0/mapdiff-x86_64-apple-darwin.tar.xz"
      sha256 "2c035c594658e458cd39c2d2ee9b48d81171b0e76a800607dedd1c9ff9dbc7f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.2.0/mapdiff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a41076862adfc8b482e9e3f247d4d43b47ba700f1b8bb9ed5c09f3013f1ddee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/avgvi/mapdiff/releases/download/v0.2.0/mapdiff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6c1b07263af25e2211052f88b6530c7dbb2150c862831aa28ea0cff7e48444d9"
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
