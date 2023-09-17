# VM for running docker containers
# vCPU:
# vRAM:
# vStorage:

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    ./disks.nix
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    (modulesPath + "/installer/scan/not-detected.nix")
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/systemd-boot.nix
    ../_mixins/containers/default.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];

    initrd = {
      availableKernelModules = [

      ];
      kernelModules = [

      ];
    };
  };

  swapDevices = [ ];

  services = {
    fstrim.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  environment.systemPackages = with pkgs; [

  ];

  hardware = {

  };

}
