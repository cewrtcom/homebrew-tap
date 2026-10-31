class TotalEch < Formula
  desc "Local HTTPS DoH server that synthesizes Cloudflare and Meta ECH records"
  homepage "https://github.com/cewrtcom/total-ech-rs"
  url "https://github.com/cewrtcom/total-ech-rs/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "8aefb0db001b31d835ed3762dc9cde2874d5cf69dee8de305bff74c0f974504c"
  license "MIT"
  head "https://github.com/cewrtcom/total-ech-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/cewrtcom/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b90e11fca36cd40c1afd2a65fe838563f4abc8a9e49f6197dc9eecf072211fa2"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Start Total ECH with:
        brew services start total-ech

      After the first start, import this CA certificate into Firefox:
        #{var}/lib/total-ech/certs/localhost-ca.pem

      Never import or share localhost-ca-key.pem.
    EOS
  end

  service do
    run [
      opt_bin/"total-ech-rs",
      "--listen", "127.0.0.1:8443",
      "--cert-dir", var/"lib/total-ech/certs"
    ]
    working_dir var/"lib/total-ech"
    log_path var/"log/total-ech.log"
    error_log_path var/"log/total-ech.log"
    keep_alive true
    process_type :background
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/total-ech-rs --version")
  end
end
