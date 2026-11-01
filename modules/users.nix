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

  environment.sessionVariables = {
    AQ_NO_MODIFIERS = "1";
    AQ_NO_ATOMIC = "1";
  };
}
