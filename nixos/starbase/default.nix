{ config, inputs, lib, pkgs, username, modulesPath, hostname, hostid, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
#    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.supermicro
    # ../_mixins/containers/default.nix
    ../_mixins/containers/docker.nix

    ../_mixins/hardware/default.nix
    ../_mixins/hardware/systemd-boot.nix

    # ../_mixins/services/nextcloud/server.nix
    ../_mixins/services/nfs/server.nix
    # ../_mixins/services/pipewire.nix

    ../_mixins/boxes/virtualization.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
      extraPools = [ "vmpool" "alpha"];
      requestEncryptionCredentials = true;
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    # kernelPackages = pkgs.linuxPackages;
    kernelParams = [ "mitigations=off" ];

    initrd = {
      kernelModules = [
        "amdgpu"
      ];
    };
  };

  swapDevices = [ ];

  services = {
    zfs.autoScrub.enable = true;

    fstrim.enable = true;

    # syncthing = {
    #   guiAddress = "0.0.0.0:8384";
    # };
  };

  networking = {
    hostName = hostname;
    hostId = hostid;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = false;
    };
    macvlans = {
      iot = {
        interface = "enp132s0f0";
        mode = "bridge";
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  powerManagement.enable = true;
  environment.systemPackages = with pkgs; [
    # syncthing

    # snipe-it
  ];

  hardware = {
    # bluetooth.enable = true;
    # bluetooth.settings = {
    #   General = {
    #     Enable = "Source,Sink,Media,Socket";
    #   };
    # };

    xone.enable = true;
  };

  # fileSystems."samba_share" = {
  #   device = "/mnt/alpha/samba";
  #   fsType = "virtiofs";
  #   options = [

  #   ];
  # };
}
