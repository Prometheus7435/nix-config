#{ hostid, hostname, lib, pkgs, ...}: {
{ lib, pkgs, ...}: {
  imports = [
    ./locale.nix
    ./nano.nix
    ./emacs-config.nix
    # ../services/flatpak.nix
    ../services/fwupd.nix
    ../services/openssh.nix
    ../services/syncthing.nix
    ../services/tailscale.nix
    ../services/zerotier.nix
  ];

  environment.systemPackages = with pkgs; [
    # desktop-file-utils
    # mergerfs
    # mergerfs-tools

    binutils
    cpufrequtils  # allows turboing on cpu cores
    curl
    file
    git
    home-manager
    htop
    killall
    man-pages
    pciutils
    rsync
    unzip
    usbutils
    wget
#    xdg-utils
    yt-dlp

    # patchelf  # might be interesting, but not seeing a current usecase
    # starship  # research more, it looks interesting
  ];

  programs = {
    dconf.enable = true;
  };

  security.rtkit.enable = true;
}
