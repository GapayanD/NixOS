{ pkgs, ... }: {
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 11;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.file.".local/share/color-schemes/Krusader-Obsidian.colors" = {
    source = ./Krusader-Obsidian.colors;
  };

  qt = {
    enable = true;

    platformTheme = {
      name = "kde";
      package = pkgs.kdePackages.plasma-integration;
    };

    kde.settings.kdeglobals = {
      General.ColorScheme = "Krusader-Obsidian";
      # Qt apps do not read the GTK icon theme, so set it here too.
      Icons.Theme = "Papirus-Dark";
    };
  };
}
