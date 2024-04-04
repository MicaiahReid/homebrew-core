class Chainhook < Formula
  desc "Reorg-aware indexing engine for the Stacks & Bitcoin blockchains"
  homepage "https://github.com/hirosystems/chainhook"
  # pull from git tag to get submodules
  url "https://github.com/hirosystems/chainhook.git",
      tag:      "v1.4.1",
      revision: "9d9f0d66dc32c7680fdabd3dba2ecf2847dd2b2a"
  license "GPL-3.0-only"
  head "https://github.com/hirosystems/chainhook.git", branch: "develop"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "chainhook-install", "--root", prefix.to_s
  end

  test do
    pipe_output("#{bin}/chainhook config new --mainnet", "n\n")
    assert_match "mode = \"mainnet\"", (testpath/"Chainhook.toml").read \
  end
end
