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
    # desktop-file-utils
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
    # v4l-utils
    wget
    # xdg-utils
    htop
    # ffmpeg_6-full
    yt-dlp
    alacritty
    # cpufrequtils  # allows turboing on cpu cores
  ];

  programs = {
    dconf.enable = true;
  };

  security.rtkit.enable = true;
}
