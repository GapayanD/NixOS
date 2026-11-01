{ inputs, ... }:
{
  imports = [
    inputs.mangowm.hmModules.mango
    ./appearance.nix
    ./input.nix
    ./binds.nix
    ./rules.nix
    ./autostart.nix
    ./noctalia.nix
  ];

  # systemd.enable defaults to true: starts mango-session.target (which links to
  # graphical-session.target) so portals and Noctalia's user service come up.
  wayland.windowManager.mango.enable = true;
}
