{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.silentSDDM.nixosModules.default];

  programs.silentSDDM = {
    enable = true;
    # other built-ins: default, default-left, default-right, ken, silvia,
    # everforest, gruvbox, nord, eldritch-abyss, eldritch-cthulhu, eldritch-dusk,
    # catppuccin-latte/frappe/macchiato/mocha
    theme = "rei";
  };

  # Explicitly set the greeter's cursor theme — SDDM's Wayland greeter often
  # fails to resolve a default cursor, which is the most common cause of a
  # missing/invisible mouse pointer on the login screen.
  services.displayManager.sddm.settings.Theme.CursorTheme = "Bibata-Modern-Classic";

  # Run the greeter itself on X11 instead of Wayland — this only affects the
  # SDDM login screen. Your Hyprland *session* still starts fully on Wayland
  # once you log in; nothing here changes that.
  #
  # SDDM requires a display backend for the greeter, so disabling wayland.enable
  # requires enabling xserver.enable in its place (hence the assertion failure
  # without this line). mkForce is needed on wayland.enable because SilentSDDM's
  # own module already sets it (wayland.enable = !xserver.enable) — a plain
  # assignment here would conflict with that instead of overriding it.
  services.xserver.enable = true;
  services.displayManager.sddm.wayland.enable = lib.mkForce false;
}
