{ config, lib, pkgs, hostname, hostid, ... }: {
  # Use passed in hostid and hostname to configure basic networking
  networking = {
    hostName = hostname;
    hostId = hostid;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = false;
    };
  };
}
