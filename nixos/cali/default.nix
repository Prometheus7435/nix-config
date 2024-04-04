# VM for running docker containers
# vCPU:
# vRAM:
# vStorage:

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    # ../_mixins/hardware/default.nix
    ../_mixins/hardware/systemd-boot.nix
    ../_mixins/containers/default.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [

    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ohci_pci"
        "ehci_pci"
        "virtio_pci"
        "ahci"
        "usbhid"
        "sr_mod"
        "virtio_blk"
      ];
      kernelModules = [

      ];
    };
  };

  swapDevices = [ ];

  services = {

  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  environment.systemPackages = with pkgs; [

  ];

  hardware = {

  };

}
