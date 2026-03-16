# `alexcardell/dots`

Personal configuration for NixOS / `nix-darwin` systems

## Usage

1. Get a NixOS install working. Requires nix > 2.4 and `experimental features = nix-command flakes` enabled in `/etc/nix/nix.conf`
1. Import GPG key
1. Clone repository
1. `git-crypt unlock`
1. Replace `./nix/nixos/hardware-configuration.nix` with the generated one: `/etc/nixos/hardware-configuration.nix` or `nixos-generate-config`
1. `cd nix && sudo nixos-rebuild --flake .#`

### Zscaler

On MacOS, if using Zscaler:

- Export Zscaler Root CA from Keychain
- `sudo cp /some/path/zscaler-root-ca.pem /etc/ssl/certs/zscaler-root-ca.pem`
- Try rebuild
- If not working (see Darwin `configuration.nix` `nix.settings.ssl-cert-file`) continue
- `sudo nvim /Library/LaunchDaemons/org.nixos.nix-daemon.plist`

    ```xml
    <key>EnvironmentVariables</key>
        <dict>
            <key>NIX_SSL_CERT_FILE</key>
            <string>/etc/ssl/certs/zscaler-root-ca.pem</string>
            <key>SSL_CERT_FILE</key>
            <string>/etc/ssl/certs/zscaler-root-ca.pem</string>
            <key>REQUESTS_CA_BUNDLE</key>
            <string>/etc/ssl/certs/zscaler-root-ca.pem</string>
            <!-- ... -->
    ```
- `sudo launchctl bootout 'system/org.nixos.nix-daemon.plist'`
- `sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nix-daemon.plist`
- verify with `sudo launchctl print 'system/org.nixos.nix-daemon'`
- Rebuild
- If `nix.settings.ssl-cert-file` isn't working, the plist changes will reset every rebuild
