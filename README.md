# Homebrew Tap

Official Homebrew tap for
[Total ECH](https://github.com/cewrtcom/total-ech-rs).

## Install Total ECH

```bash
brew install cewrtcom/tap/total-ech
brew services start total-ech
```

Apple Silicon macOS installs a prebuilt bottle. Other platforms fall back to a
source build and require the Rust toolchain.

The service listens on:

```text
https://127.0.0.1:8443/doh-ech
```

After the first start, import only this CA certificate into Firefox:

```text
$(brew --prefix)/var/lib/total-ech/certs/localhost-ca.pem
```

Never import, commit, or share `localhost-ca-key.pem`.

Manage the service with:

```bash
brew services info total-ech
brew services restart total-ech
brew services stop total-ech
```

Service logs are written to:

```text
$(brew --prefix)/var/log/total-ech.log
```

See the [Total ECH README](https://github.com/cewrtcom/total-ech-rs#readme)
for Firefox configuration, policy behavior, security notes, and troubleshooting.
