class Wireshare < Formula
  desc "Peer-to-peer sharing for Gnutella, BitTorrent, magnet, and eD2k"
  homepage "https://github.com/nmatavka/hermes-wireshare"
  url "https://github.com/nmatavka/hermes-wireshare/releases/download/release/7.0/WireShare-7.0-source.tar.gz"
  sha256 "a72fc74114335f4694de436371eac33e765d782b03bdd91aff57c1ff187ccbf3"
  license "GPL-3.0-or-later"
  version "7.0"

  depends_on "gradle" => :build
  depends_on "openjdk@21"

  def install
    env_java = Formula["openjdk@21"].opt_prefix
    ENV["JAVA_HOME"] = env_java

    system "./gradlew", "--no-daemon", "wireShareJar"

    bin.install "packaging/common/launchers/WireShare" => "WireShare"
    share.install "WireShare.jar" => "wireshare/WireShare.jar"
    prefix.install "packaging/common/app/cx.hermes.WireShare.desktop" => "share/applications/cx.hermes.WireShare.desktop"
    prefix.install "packaging/common/app/cx.hermes.WireShare.metainfo.xml" => "share/metainfo/cx.hermes.WireShare.metainfo.xml"
    prefix.install "packaging/common/icons" => "share/icons"
  end

  test do
    assert_match "WireShare", shell_output("#{bin}/WireShare --help", 1)
  end
end
