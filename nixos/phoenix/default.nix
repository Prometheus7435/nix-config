# Motherboard:
# CPU: AMD Ryzen 5 PRO 4650U
# GPU: Radeon Graphics
# RAM: 32GB
# NVME: Samsung SSD 980 1TB

{ config, inputs, lib, pkgs, username, modulesPath, sys_arch, tagstudio, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/mobile.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/systemd-boot.nix
    ../_mixins/desktop/creative.nix
    ../_mixins/desktop/steam.nix

    ../_mixins/services/media-edit.nix
    # ../_mixins/services/nfs/client.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/services/silly.nix

    ../_mixins/containers/docker.nix

    ../_mixins/boxes/virtualization.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Only install the docs I use
  documentation.enable = false;
  documentation.nixos.enable = false;
  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

  swapDevices = [ ];

  nix.settings.system-features = [ "nixos-test" "benchmark" "big-parallel" "gcc-znver2" "gccarch-znver2"];

  nixpkgs = {
    hostPlatform = {
      system = "x86_64-linux";
      # gcc.arch = "znver2";
      # gcc.tune = "znver2";
    };
    buildPlatform = {
      system = "x86_64-linux";
      # gcc.arch = "znver2";
      # gcc.tune = "znver2";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_6_12;
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [ "nohibernate"];
    kernelModules = [
      "kvm-amd"
    ];
    initrd = {
      availableKernelModules = [
        # "sd_mod"

      ];
    };
  };

  hardware = {

  };

  # zramSwap = {
  #   enable = true;
  #   algorithm = "zstd";
  #   memoryPercent = 30;
  # };

  services = {
    fstrim.enable = true;
    fprintd.enable = true; # fingerprint reader
  };

  security = {
    pam.services.login.fprintAuth = true;
    pam.services.xscreensaver.fprintAuth = true;
  };

  environment.systemPackages = [
    pkgs.qbittorrent
    pkgs.kitty

    ## spell checking
    pkgs.enchant
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-science
    pkgs.ispell
    pkgs.hunspellDicts.en_US-large
    pkgs.hunspellDicts.en_GB-large

    ## citation manager
    # pkgs.zotero

    ## playing with installing KDE themes
    pkgs.catppuccin-kde
    pkgs.arc-kde-theme
    pkgs.nordic

    # pkgs.macchina
    pkgs.syncthing

    pkgs.octaveFull

    pkgs.tmux

    # pkgs.libhugetlbfs
    pkgs.palemoon-bin
    pkgs.librewolf-bin

    pkgs.compose2nix
    pkgs.ghostty
    # pkgs.tagstudio

    pkgs.openssl

    # pkgs.android-tools
  ];
}
