{pkgs, ...}: {
  users.users.denver = {
    isNormalUser = true;
    description = "Denver";
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
    shell = pkgs.fish;
    homeMode = "711";
  };

  security.pam.services.sddm.enableGnomeKeyring = true;

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  # AQ_NO_MODIFIERS / AQ_NO_ATOMIC were removed: they only affect Hyprland's
  # Aquamarine backend. Mango and Umbriel are wlroots-based and ignore them.
}
