#{ hostid, hostname, lib, pkgs, ...}: {
{ lib, pkgs, ...}:
# { lib, pkgs, system, arch, ...}:
# let
#   pkgs = import <nixpkgs> {
#     localSystem = {
#       gcc.arch = arch;
#       gcc.tune = arch;
#       system = system;
#     };
#   };
# in
{
  imports = [
    ./locale.nix
    ./nano.nix
    ./emacs-config.nix
    # ../services/flatpak.nix
    ../services/fwupd.nix
    ../services/openssh.nix
    # ../services/syncthing.nix
    ../services/tailscale.nix
    # ../services/zerotier.nix
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
    gpart
    home-manager
    htop
    killall
    libgccjit
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
