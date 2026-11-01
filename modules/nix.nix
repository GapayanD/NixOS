{ ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;

    # Keep cache.nixos.org and add project caches. The flake's nixConfig also
    # supplies these for the first build, before this system config is active.
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://umbriel.cachix.org"
    ];
    trusted-substituters = [
      "https://noctalia.cachix.org"
      "https://umbriel.cachix.org"
    ];
    trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
    ];
    trusted-users = [ "root" "@wheel" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };
}
