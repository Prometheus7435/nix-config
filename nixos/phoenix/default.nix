# Motherboard:
# CPU: AMD Ryzen 5 PRO 4650U
# GPU: Radeon Graphics
# RAM: 32GB
# NVME: Samsung SSD 980 1TB

{ config, inputs, lib, pkgs, username, modulesPath, sys_arch, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
    # inputs.nixos-hardware.nixosModules.common-pc
    # inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../_mixins/hardware/default.nix
    # ../_mixins/hardware/mobile.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/systemd-boot.nix
    # ../_mixins/hardware/zfs.nix
    # ../_mixins/desktop/creative.nix

    # ../_mixins/services/cac.nix
    ../_mixins/services/media-edit.nix
    # ../_mixins/services/nfs/client.nix
    ../_mixins/services/pipewire.nix
    # ../_mixins/services/nextcloud/server.nix
    ../_mixins/containers/default.nix

    # ../_mixins/services/keycloak.nix
    # ./optimised_openssl.nix  # test with arch specifics

    # ../_mixins/containers/AudioBookShelf-docker.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Only install the docs I use
  documentation.enable = true;
  documentation.nixos.enable = false;
  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

  swapDevices = [ ];

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.hostPlatform = {
  #  gcc.arch = "znver2"; # sys_arch;
  #  gcc.tune = "znver2"; # sys_arch;
    system = "x86_64-linux";
    system-features = [ "gccarch-znver2" ];
    # requiredSystemFeatures = [ "gccarch-znver2" ];
  };
  # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages;
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
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
    # zfs.autoScrub = {
    #   enable = true;
    #   interval = "monthly";
    # };
    fstrim.enable = true;

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
    # pkgs.ansible
    # pkgs.sshpass

    # creating cloud images
    # pkgs.xorriso
    # pkgs.cloud-init
    # pkgs.openssh

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
    # pkgs.postgresql
    pkgs.ktailctl
  ];
}
