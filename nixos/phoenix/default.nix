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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # supportedFilesystems = [ "ntfs" "xfs" "ext4" ];
    # kernelParams = [ "mem_sleep_default=deep" "nohibernate"];
    kernelModules = [
      "kvm-amd"
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
    # pkgs.google-chrome
    pkgs.kitty
    pkgs.eagle
    pkgs.kicad

    pkgs.jupyter-all

    pkgs.haruna
  ];
}
