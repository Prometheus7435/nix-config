{ lib, pkgs, ...}: {
  imports = [
    ./locale.nix
    ./nano.nix
    ./emacs-config.nix
    ../services/openssh.nix
    ../services/tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
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
    yt-dlp
  ];

  programs = {
    dconf.enable = true;
  };

  security.rtkit.enable = true;
}
