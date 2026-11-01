{ pkgs, inputs, ... }:
let
  krusader-themed = pkgs.symlinkJoin {
    name = "krusader-themed";
    paths = [ pkgs.krusader ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/krusader \
        --set QT_QPA_PLATFORMTHEME kde \
        --prefix QT_PLUGIN_PATH : ${pkgs.kdePackages.plasma-integration}/${pkgs.qt6.qtbase.qtPluginPrefix}
    '';
  };

  cliamp = inputs.cliamp.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (_: {
    vendorHash = "sha256-4IobrZ8UBXehfWH1WvzaICcuZlk9zZaVHW7c7h1Wex0=";
  });
in
{
  home.packages = with pkgs; [
    # Web browser
    brave
    librewolf
    qutebrowser

    # Communication and file sharing
    telegram-desktop
    vesktop
    localsend

    # Security and privacy
    bitwarden-desktop

    # Notes and office productivity
    obsidian
    onlyoffice-desktopeditors

    # Development and programming
    nodejs
    python3
    vscode
    jetbrains.webstorm
    tk
    kdePackages.kate
    zed-editor
    intellij-idea
    github-cli
    lazygit
    meld
    distroshelf
    distrobox

    # Terminal and command-line tools
    micro
    wget
    dnsutils
    tree
    grc
    bat
    btop
    gdu
    kdePackages.konsole

    # Terminal fun
    unimatrix

    # Media players and music
    cliamp
    celluloid
    vlc

    # Images and photos
    gthumb

    # Video downloading and processing
    parabolic
    yt-dlp
    ffmpeg
    motrix

    # File Manager
    krusader-themed
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kio-fuse

    # Archive Management
    kdePackages.ark

    # File Previews and Image Formats
    kdePackages.qtsvg
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kimageformats

    # Android device tools
    scrcpy

    # System tools and application support
    flatpak

    # Desktop appearance
    bibata-cursors

    # Nix language support
    nixd

    # Formatting and linting
    nixfmt
    statix
    deadnix
  ];
}
