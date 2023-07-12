#{ hostid, hostname, lib, pkgs, ...}: {
{ lib, pkgs, ...}: {
  imports = [
    ./locale.nix
    ./nano.nix
    # ./emacs-config.nix
    ../services/fwupd.nix
    ../services/openssh.nix
    ../services/tailscale.nix
    # ../services/zerotier.nix
  ];

  environment.systemPackages = with pkgs; [
    emacs
    binutils
    curl
    desktop-file-utils
    file
    git
    home-manager
    killall
    man-pages
    mergerfs
    mergerfs-tools
    nano
    pciutils
    rsync
    unzip
    usbutils
    v4l-utils
    wget
    xdg-utils
    htop
    gtop
    btop
    # # delete this when I figure out emacs overlay
    # emacs
  ];

  # # Use passed in hostid and hostname to configure basic networking
  # networking = {
  #   hostName = hostname;
  #   hostId = hostid;
  #   useDHCP = lib.mkDefault true;
  #   firewall = {
  #     enable = false;
  #   };
  # };

  programs = {
    dconf.enable = true;
  };

  security.rtkit.enable = true;
}
