{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      inter
      fira-code
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono

      # Needed for caelestia-shell's UI: it uses Material Symbols Rounded for
      # icons everywhere (bar, launcher, dashboard...) and CaskaydiaCove NF for
      # its own mono/monospace text. Without these the shell still runs, but
      # icons render as boxes and mono text falls back to whatever's default.
      material-symbols
      nerd-fonts.caskaydia-cove
    ];

    fontconfig.defaultFonts = {
      serif     = [ "Noto Serif" ];
      sansSerif = [ "Inter" ];
      monospace = [ "FiraCode Nerd Font" ];
      emoji     = [ "Noto Color Emoji" ];
    };
  };
}
