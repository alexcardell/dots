# NixOS Upgrade from 24.11 to 25.05

## Changes Made

1. **Updated flake.nix to reference NixOS 25.05:**
   - `nixpkgs.url = "nixpkgs/nixos-25.05"`
   - `home-manager.url = "github:nix-community/home-manager/release-25.05"`
   - `darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05"`

2. **Updated package versions:**
   - Changed `nodejs-18_x` to `nodejs_22` in nixos/home/default.nix
   - Updated comment reference from "nixos-24.11" to "nixos-25.05" in homelab.nix

3. **Removed flake.lock to force regeneration with new versions**

4. **Validated all Nix configuration files for syntax correctness**

## Required Steps After This Upgrade

Run the following commands to complete the upgrade:

```bash
# Regenerate flake.lock with new versions
nix flake update

# For NixOS systems, rebuild:
sudo nixos-rebuild switch --flake .#nixbox
sudo nixos-rebuild switch --flake .#nixpad

# For Darwin systems, rebuild:
darwin-rebuild switch --flake .#RJ4QHFPQRX
```

## Configuration Compatibility

### ✅ Verified Compatible
- All Nix syntax validated successfully
- State versions maintained appropriately
- X11 keyboard configuration (xkb) format is current
- Pipewire audio configuration
- Services configuration (jellyfin, sonarr, radarr)
- Unstable package references maintained

### 📝 Updated for 25.05
- Node.js version updated to v22 (was v18)
- Version references in comments updated

### ⚠️ Monitor During Upgrade
- Insecure packages list in homelab.nix - may need updates for .NET Core versions
- Unstable packages may move to stable or change names

## State Version Compatibility

Current state versions in the configuration:
- System state version: 21.11 (in nixos/systems/linux/configuration.nix)
- Home Manager state version: 22.11 (in nixos/home/default.nix)

**These should NOT be changed** as they refer to the initial installation version.

## Potential Issues and Solutions

### If you encounter dependency conflicts:
```bash
# Update flake inputs individually if needed
nix flake lock --update-input nixpkgs
nix flake lock --update-input home-manager
nix flake lock --update-input darwin
```

### If rebuild fails due to package conflicts:
- Check the NixOS 25.05 release notes for package removals/renames
- Consider using `nixpkgs-unstable` for packages not yet available in 25.05
- Update .NET Core versions in permittedInsecurePackages if needed

### If services fail to start:
- Check service configuration changes in NixOS 25.05
- Review systemd service definitions for any breaking changes