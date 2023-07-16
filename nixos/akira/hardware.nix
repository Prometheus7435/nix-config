# Motherboard:
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
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    wacomtablet
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
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for FF/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        intel-ocl
        rocm-opencl-icd
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
    sensor = {
      # automatic screen orientation
      iio = {
        enable = true;
      };
    };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services = {
    xserver.libinput.enable = true;
    tlp = {
      settings = {
        START_CHARGE_THRESH_BAT0 = "75";
        STOP_CHARGE_THRESH_BAT0 = "80";
      };
    };
    # fingerprint reader
    fprintd.enable = true;

  };
  security = {
    pam.services.login.fprintAuth = true;
    pam.services.xscreensaver.fprintAuth = true;
  };
}
