# Motherboard:
# CPU: AMD Ryzen 5 PRO 4650U
# GPU: Radeon Graphics
# RAM: 32GB
# NVME: Samsung SSD 980 1TB

{ config, inputs, lib, pkgs, username, modulesPath, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/mobile.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/systemd-boot.nix
    # ../_mixins/hardware/zfs.nix
    ../_mixins/desktop/creative.nix

    ../_mixins/services/cac.nix
    ../_mixins/services/media-edit.nix
    # ../_mixins/services/nfs/client.nix
    ../_mixins/services/pipewire.nix

    # ../_mixins/containers/default.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices = [ ];

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-v3";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_lqx; # lqx is less frequent release version of zen
    # kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # supportedFilesystems = [ "ntfs" "xfs" "ext4" ];
    kernelParams = [ "nohibernate"];
    kernelModules = [
      "kvm-amd"
      "sse3"
      "ssse3"
      "sse4_1"
      "sse4_2"
      "sse4a"
      "aes"
      "avx"
      "avx2"
      "fma"
    ];
    initrd = {
      availableKernelModules = [
        "sd_mod"
      ];
    };
  };

  hardware = {

  };

  services = {
    zfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
    fstrim.enable = true;
    # xremap = {
    #   userName = username;  # run as a systemd service in alice
    #   serviceMode = "user";  # run xremap as user
    #   # withKDE = true;
    #   config = {
    #     modmap = [
    #       {
    #       name = "Global";
    #       remap = { "CapsLock" = "Ctrl"; };  # globally remap CapsLock to Ctrl
    #       }
    #     ];
    #   };
    # };

    # tlp = {
    #   settings = {
    #     START_CHARGE_THRESH_BAT0 = "70";
    #     STOP_CHARGE_THRESH_BAT0 = "82";
    #   };
    # };

    # fingerprint reader
    fprintd.enable = true;

  };

  security = {
    pam.services.login.fprintAuth = true;
    pam.services.xscreensaver.fprintAuth = true;
  };
  # environment.systemPackages = with pkgs; [
  environment.systemPackages = [
    # just fun
    pkgs.cbonsai
    pkgs.cowsay
    pkgs.fortune

    pkgs.qbittorrent

    # need for ansible to work
    pkgs.ansible
    pkgs.sshpass

    # creating cloud images
    pkgs.xorriso
    pkgs.cloud-init
    pkgs.openssh

    # pkgs.logseq
    pkgs.kitty
    # pkgs.eagle
    # pkgs.kicad

    # pkgs.jupyter-all

    pkgs.haruna

    # pkgs.ollama
    pkgs.snowmachine
    # pkgs.dtc

    # spell checking
    pkgs.enchant
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-science
    pkgs.ispell
    pkgs.nuspell
    pkgs.hunspell
    # pkgs.hunspellDicts.en_US
    pkgs.hunspellDicts.en_US-large
    pkgs.hunspellDicts.en_GB-large

    # weather
    pkgs.wego

    # citation manager
    # pkgs.zotero
  ];

  # # temp Samba config for Home Assistant
  # fileSystems."/mnt/share" = {
  #     device = "//home/shyfox/samba";
  #     fsType = "cifs";
  #     options = let
  #       # this line prevents hanging on network split
  #       automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

  #     in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  # };
    # pkgs.appimageTools.wrapType1 { # or wrapType2
    #   name = "tagspaces";
    #   src = pkgs.fetchurl {
    #     url = "https://github.com/tagspaces/tagspaces/releases/download/v5.6.2/tagspaces-linux-x86_64-5.6.2.AppImage";
    #     hash = "439137cb0484fbd7b78df2dadbca8c714acfa789f9484009390e60897243e0b8";
    #   };
    # }

}
