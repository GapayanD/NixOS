# NixOS Configuration

A personal, flake-based NixOS configuration for a Wayland desktop. This repository has **two desktop branches**: the older Hyprland setup on `main` and the newer, experimental MangoWM setup on `mango`, which also includes Umbriel-related testing.

> **Choose your branch before rebuilding.** The two branches represent different stages of the desktop setup. Their window-manager configuration and supporting modules are not interchangeable. Read the branch notes below and inspect the selected flake before applying it to a machine.

## Desktop branches

| Branch | Desktop direction | Status | What it is for |
|---|---|---|---|
| [`main`](https://github.com/GapayanD/NixOS/tree/main) | **Hyprland** | Older configuration | The previous Hyprland-based desktop, with UWSM, Noctalia, and the Hyprland-specific configuration and plugins. |
| [`mango`](https://github.com/GapayanD/NixOS/tree/mango) | **MangoWM + Umbriel testing** | Newer / experimental | The newer desktop configuration centered on MangoWM, with Umbriel included as a test/experimental path. Expect active changes while this setup is being evaluated. |

### `main` — Hyprland (older setup)

The `main` branch preserves the previous Hyprland desktop. Its configuration includes:

- Hyprland managed through UWSM, with XWayland and XDG desktop portal support.
- Noctalia as the desktop shell, with a dark Catppuccin theme.
- SDDM with the SilentSDDM `rei` theme.
- Lua-based Hyprland customization, split into appearance, keybindings, window rules, and workspace settings.
- The Hyprspace workspace overview plugin.
- Home Manager-managed user applications, shell settings, themes, and dotfiles.

This is the branch to use when you want the older Hyprland environment.

### `mango` — MangoWM and Umbriel (experimental setup)

The `mango` branch is the newer desktop experiment. It moves the configuration toward **MangoWM** and includes **Umbriel-related testing**. Treat this branch as work in progress rather than as a drop-in replacement for `main`.

Before switching to or rebuilding this branch:

1. Review its `flake.nix`, `flake.lock`, NixOS modules, and Home Manager modules.
2. Check which compositor/session is enabled by default and how the login/session is started.
3. Review the Umbriel test configuration separately from the normal MangoWM session.
4. Inspect `nix flake show` to confirm the NixOS configuration name exported by this branch.
5. Build the selected configuration before activating it.

The `main` branch's Hyprland Lua files, Hyprspace plugin settings, and Hyprland-specific module assumptions should not be copied into the `mango` branch unless they have been deliberately adapted.

## Selecting a branch

Clone a specific branch:

```bash
# Older Hyprland setup
git clone --branch main --single-branch https://github.com/GapayanD/NixOS.git NixOS-main

# Newer MangoWM / Umbriel testing setup
git clone --branch mango --single-branch https://github.com/GapayanD/NixOS.git NixOS-mango
```

Or switch branches in an existing checkout:

```bash
git fetch origin
git switch main       # older Hyprland setup
# or
git switch mango      # newer MangoWM / Umbriel testing setup
```

Check the current branch and working tree before making changes:

```bash
git branch --show-current
git status --short
```

Keep each branch's `flake.nix` and `flake.lock` together. Do not copy a lock file from one branch to the other unless you intentionally want to change the pinned dependency set.

## `main` branch: desktop and applications

The following inventory describes the **Hyprland `main` branch**, not necessarily the newer `mango` branch.

| Area | Configuration |
|---|---|
| Bootloader | systemd-boot (UEFI) |
| Window manager | Hyprland, UWSM, XWayland |
| Desktop shell | Noctalia, dark Catppuccin theme |
| Login manager | SDDM with SilentSDDM `rei` theme |
| Audio | PipeWire, ALSA, PulseAudio compatibility |
| Shell | Fish, Starship, Eza, Fzf, Zoxide |
| Terminals | WezTerm and Konsole |
| Editors / IDEs | Helix, VS Code, Zed, Kate, IntelliJ IDEA, WebStorm |
| Browsers | Brave, LibreWolf, qutebrowser, Zen Browser |
| File management | Krusader with KDE integration, KIO tools |
| Media | VLC, Celluloid, CLIamp, yt-dlp, FFmpeg |
| Communication | Telegram Desktop, Vesktop, LocalSend |
| Other | Bitwarden, Obsidian, ONLYOFFICE, Distrobox, scrcpy |

The package list is maintained in `home/packages.nix` on `main`; the table is a selection, not an exhaustive inventory.

## Repository layout on `main`

This tree documents the older Hyprland branch. The `mango` branch may have a different module layout.

```text
.
├── configuration.nix
├── flake.lock
├── flake.nix
├── hardware-configuration.nix
├── home
│   ├── direnv.nix
│   ├── fastfetch.nix
│   ├── fish.nix
│   ├── git.nix
│   ├── helix.nix
│   ├── mango
│   │   ├── appearance.nix
│   │   ├── autostart.nix
│   │   ├── binds.nix
│   │   ├── default.nix
│   │   ├── input.nix
│   │   ├── noctalia.nix
│   │   └── rules.nix
│   ├── mpd.nix
│   ├── packages.nix
│   ├── theming.nix
│   ├── umbriel
│   │   ├── animation.nix
│   │   ├── appearance.nix
│   │   ├── binds.nix
│   │   ├── default.nix
│   │   ├── general.nix
│   │   ├── input.nix
│   │   ├── layout.nix
│   │   └── rules.nix
│   ├── wezterm.lua
│   ├── wezterm.nix
│   └── xdg.nix
├── home.nix
├── modules
│   ├── adb.nix
│   ├── audio.nix
│   ├── boot.nix
│   ├── compositors.nix
│   ├── fonts.nix
│   ├── hardware.nix
│   ├── locale.nix
│   ├── network.nix
│   ├── nix.nix
│   ├── polkit.nix
│   ├── programs
│   │   ├── dev.nix
│   │   └── java.nix
│   ├── sddm-theme.nix
│   ├── services.nix
│   ├── shell.nix
│   ├── users.nix
│   └── zen-browser.nix
└── README.md
```

On `main`, `configuration.nix` imports the system modules, while `home.nix` is the Home Manager entry point for user applications and dotfiles. The Hyprspace plugin path is generated from the Nix store by `home/hyprland/default.nix`, rather than hard-coded in the Lua configuration.

## Requirements

- A working NixOS installation.
- A compatible 64-bit Linux system. The previously reviewed `main` flake targets `x86_64-linux`; check the selected branch's `flake.nix` for its supported systems.
- Flakes and the `nix-command` experimental feature.
- An internet connection to fetch flake inputs and packages.
- A backup of the existing NixOS configuration and a recovery path, especially when changing the display manager or compositor.

## Building and applying a configuration

These steps apply to whichever branch is currently checked out. **Do not run a rebuild until you have confirmed the selected branch and reviewed its host configuration.**

1. Back up your current `/etc/nixos` configuration and keep your generated `hardware-configuration.nix`.
2. Select `main` or `mango` using the commands above.
3. Inspect the flake outputs and confirm the NixOS configuration name:

   ```bash
   nix flake show .
   ```

4. Build without activating. Replace `<host>` with the NixOS configuration name shown by `nix flake show`:

   ```bash
   sudo nixos-rebuild build --flake .#<host>
   ```

5. Once the build succeeds and you have reviewed the changes, activate it:

   ```bash
   sudo nixos-rebuild switch --flake .#<host>
   ```

6. Reboot when required, particularly after bootloader, kernel, or low-level hardware changes.

For the previously reviewed `main` branch, the host output is `nixos`, so the build and switch target is `.#nixos`. Confirm the output again when using `mango` rather than assuming it is identical.

## Adapting the `main` branch to another machine

The following notes apply to the previously reviewed **`main` branch**. Re-check the corresponding files on `mango` before assuming these values are unchanged.

| File | Setting to review |
|---|---|
| `flake.nix` | The system, username, hostname, and NixOS configuration output. The reviewed version uses `x86_64-linux`, user `denver`, and host output `nixos`. |
| `modules/users.nix` | The username is explicitly declared as `denver`; keep it consistent with the flake or refactor it to use a shared variable. |
| `modules/network.nix` | The hostname is hard-coded as `nixos`. |
| `hardware-configuration.nix` | Machine-specific filesystem and swap UUIDs, a Btrfs layout, EFI partition, and AMD-related hardware settings. Generate this file for the target machine; do not reuse it blindly. |
| `modules/locale.nix` | Time zone `Asia/Manila`, locale `en_PH.UTF-8`, and keyboard layout `us`. |
| `configuration.nix` and `home.nix` | Preserve the existing `system.stateVersion` and `home.stateVersion` values when migrating an installation. Do not change them just to follow a newer release. |
| `home/fish.nix` | The `rebuild` and `update` aliases assume the repository is at `/etc/nixos`. |

Also review device-specific settings in `home/hyprland/` and application preferences under `home/` before applying `main` to another computer.

## Updating and rollback

Update the flake inputs for the selected branch and rebuild:

```bash
sudo nix flake update --flake /etc/nixos
sudo nixos-rebuild build --flake /etc/nixos#<host>
sudo nixos-rebuild switch --flake /etc/nixos#<host>
```

To return to the previous system generation:

```bash
sudo nixos-rebuild switch --rollback
```

Keep in mind that updating `flake.lock` changes the dependency revisions for the current branch. Review the diff and test a build before switching.

## Security and privacy notes

These observations are from the previously reviewed **`main` branch**; verify the equivalent settings on `mango` before relying on them.

- **SSH:** OpenSSH is enabled in the configuration but is removed from the normal boot target, so it does not start automatically. When started manually, password authentication is allowed and root login is disallowed. Prefer public-key authentication and disable password authentication before exposing SSH to an untrusted network.
- **Firewall:** TCP and UDP port `53317` are allowed for LocalSend. Review port openings when changing applications or services.
- **Nix trusted users:** `root` and the `wheel` group are configured as trusted Nix users. Keep `wheel` membership limited to administrators you trust.
- **Hardware identifiers:** `hardware-configuration.nix` contains filesystem and swap UUIDs for the configured machine. Avoid reusing it on other devices and consider whether you want these identifiers public.
- **Secrets:** Never commit passwords, private keys, access tokens, or other credentials. A `.gitignore` is helpful but does not guarantee that every sensitive file or past commit is clean.

## Validation checklist

Run these checks on the branch you intend to use:

```bash
# Confirm branch and working tree
git branch --show-current
git status --short

# Inspect available flake outputs
nix flake show .

# Evaluate/check the flake
nix flake check

# Build the selected NixOS host without activating it
sudo nixos-rebuild build --flake .#<host>
```

A successful build is an important check before switching generations. It does not replace reviewing hardware-specific settings, boot behavior, session startup, and recovery options.

## References

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix flakes documentation](https://nix.dev/concepts/flakes.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hypr.land/)
- [MangoWM documentation](https://mangowm.github.io/docs/installation/)
- [Umbriel documentation](https://github.com/noctalia-dev/umbriel)
- [Noctalia](https://noctalia.dev/)

---

This repository records a personal desktop configuration as it evolves. `main` preserves the previous Hyprland setup; `mango` is the newer MangoWM/Umbriel testing track. Review the files and build the selected branch before activating it on your machine.
