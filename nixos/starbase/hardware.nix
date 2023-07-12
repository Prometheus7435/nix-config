# Motherboard:
# CPU:
# GPU:
# GPU:
# RAM:
# NVME:
# NVME:
# Storage:
# SATA:
# SAS:

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
#    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
#    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.supermicro
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # fileSystems."/" =
  #   { device = "NIXROOT/root";
  #     fsType = "zfs";
  #   };

  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/2BA9-CBA1";
  #     fsType = "vfat";
  #   };

  # fileSystems."/home" =
  #   { device = "NIXROOT/home";
  #     fsType = "zfs";
  #   };

  swapDevices = [ ];

   # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
#  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp132s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp132s0f1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    nvtop  # top like program for gpus
  ];

  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xone.enable = true;
  };
}
