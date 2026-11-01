{ ... }:
{
  # Full config reference: https://docs.noctalia.dev/v5/configuration/
  programs.noctalia = {
    enable = true;
    settings = {
      bar.main = {
        shadow = false;
        contact_shadow = false;
      };
      dock.shadow = false;
      shell.panel.shadow = false;
    };
  };
}
