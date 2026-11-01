{ lib, ... }: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "9.9.9.9"
    "1.1.1.1"
  ];
  networking.networkmanager.dns = "none";

  # SSH is configured but does not start at boot.
  # Turn it on when needed:  sudo systemctl start sshd
  # Turn it off again:       sudo systemctl stop sshd
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  systemd.services.sshd.wantedBy = lib.mkForce [ ];

  # Only LocalSend stays open. Port 22 is opened by the SSH module itself.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
}
