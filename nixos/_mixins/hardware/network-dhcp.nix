{ hostid, hostname, lib, pkgs, ...}: {
  imports = [
  #  ./locale.nix
  ];

  networking = {
    hostName = hostname;
    hostId = hostid;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = false;
    };
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp132s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp132s0f1.useDHCP = lib.mkDefault true;
  };
}
