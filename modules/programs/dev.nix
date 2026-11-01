{ pkgs, username, ... }:

{
  # Docker for the outbox-relay stack and Testcontainers.
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];

  # Lets uv/pip manylinux wheels and other prebuilt binaries find shared libraries.
  programs.nix-ld.enable = true;

  # Tooling the outbox-relay Makefile and mvnw shim expect on PATH.
  environment.systemPackages = with pkgs; [
    gnumake
    uv
    maven
  ];
}
