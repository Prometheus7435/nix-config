# ThinkPad X1 Tablet Gen 3
# Motherboard:
# CPU: Intel i7-8650U (8)
# GPU:
# RAM: 16GB
# NVME: 500Gb

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
    # inputs.nixos-hardware.nixosModules.common-pc
    # inputs.nixos-hardware.nixosModules.common-pc-ssd
    (modulesPath + "/installer/scan/not-detected.nix")
    ../_mixins/hardware/mobile.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/zfs.nix
    ../_mixins/hardware/default.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiInstallAsRemovable = true;
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 8;
        # splashImage = ./bonsai.png;
      };
      timeout = 3;
    };

    # kernelParams = [ "mem_sleep_default=deep" ];
    extraModulePackages = with config.boot.kernelPackages; [
      # acpi_call
    ];

    initrd = {
      availableKernelModules = [

      ];
      kernelModules = [

      ];
    };
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [

  ];

  hardware = {
    # bluetooth.enable = true;
    # bluetooth.settings = {
    #   General = {
    #     Enable = "Source,Sink,Media,Socket";
    #   };
    # };
    # opengl = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     intel-media-driver # LIBVA_DRIVER_NAME=iHD
    #     vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for FF/Chromium)
    #     vaapiVdpau
    #     libvdpau-va-gl
    #     intel-ocl
    #     rocm-opencl-icd
    #   ];
    #   driSupport = true;
    #   driSupport32Bit = true;
    # };
    # sensor = {
    #   # automatic screen orientation
    #   iio = {
    #     enable = true;
    #   };
    # };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services = {
    xserver.libinput.enable = true;
    tlp = {
      settings = {
        START_CHARGE_THRESH_BAT0 = "75";
        STOP_CHARGE_THRESH_BAT0 = "95";
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
