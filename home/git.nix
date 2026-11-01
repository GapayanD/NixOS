{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "GapayanD";
        email = "275974519+GapayanD@users.noreply.github.com";
      };

      credential = {
        helper = "!gh auth git-credential";
      };
    };
  };
}
