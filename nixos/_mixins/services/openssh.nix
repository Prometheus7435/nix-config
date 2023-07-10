{ lib, ... }: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkDefault "no";
#      PermitRootLogin = no;
      X11Forwarding = true;
#      passwordAuthentication = false;
    };
  };
  programs.ssh.startAgent = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
}
