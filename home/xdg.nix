{ ... }: {
  # Default applications
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = "org.kde.krusader.desktop";
    };
  };
}
