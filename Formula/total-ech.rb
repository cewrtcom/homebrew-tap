class TotalEch < Formula
  desc "Local HTTPS DoH server that synthesizes Cloudflare and Meta ECH records"
  homepage "https://github.com/cewrtcom/total-ech-rs"
  url "https://github.com/cewrtcom/total-ech-rs/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "24525b345a5e29a874c2c15f6e9060844aeec5c0fbcf8148357864da881755c3"
  license "MIT"
  head "https://github.com/cewrtcom/total-ech-rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def post_install
    (var/"lib/total-ech").mkpath
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
      "--cert-dir", var/"lib/total-ech/certs",
    ]
    working_dir var/"lib/total-ech"
    keep_alive true
    process_type :background
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/total-ech-rs --version")
  end
end
