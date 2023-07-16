# Motherboard: MSI something
# CPU: AMD 3700X
# GPU: Nvidia A4000
# RAM: 32GB 3200Mhz Tri-something
# NVME: Samsung 980 PCIe4x4 1Tb
# Storage:
# SATA:
# SAS:

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    # inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices = [ ];

   # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp132s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp132s0f1.useDHCP = lib.mkDefault true;


  # networking = {
  #   interfaces = {
  #     enp39s0.useDHPC = lib.mkDefault true;  # motherboard ethernet
  #     # right fiber connection
  #     enp35s0f0 = {
  #       useDHCP = lib.mkDefault true;
  #     };
  #     # left fiber connection
  #     enp35s0f1 = {
  #       useDHCP = lib.mkDefault true;
  #       # ipv4 = {
  #       #   addresses = [
  #       #     {
  #       #       address = "10.10.10.50";
  #       #       prefixLength = 24;
  #       #     };
  #       #   ];
  #       # };
  #     };
  #   };
  #   defaultGateway = {
  #     address = "10.10.10.1";
  #     interface = "enp35s0f1";
  #   };
  #   nameservers = [
  #     "10.10.10.1"
  #   ];
  # };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    nvtop  # top like program for gpus
    # cudaPackages.cudatoolkit
  ];

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      # "nvidia-settings"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  # Make sure opengl is enabled
  hardware = {
    cpu = {
      amd = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };

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

    nvidia = {
      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;

      prime = {
        nvidiaBusId = "PCI:45:0:0";
      };

      # Use the open source version of the kernel module
      # Only available on driver 515.43.04+
      # open = true;

      # Enable the nvidia settings menu
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
