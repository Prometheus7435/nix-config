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

# {
#   networking = {
#     networkmanager = {
#       enable = true;
#       # wifi = {
#       #   backend = "iwd";
#       # };
#     };
#   };
#   # Workaround https://github.com/NixOS/nixpkgs/issues/180175
#   systemd.services.NetworkManager-wait-online.enable = false;
  # }

}
