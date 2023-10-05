# ThinkPad X1 Tablet Gen 3
# Motherboard:
# CPU: Intel i7-8650U (8)
# GPU:
# RAM: 16GB
# NVME: 500Gb

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    # ./disks.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/mobile.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/zfs.nix
    ../_mixins/services/nfs/client.nix
    ../_mixins/services/pipewire.nix
    (modulesPath + "/installer/scan/not-detected.nix")
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
    # zfs.autoScrub.enable = true;
    # fstrim.enable = true;
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    # nvtop-amd
  ];

  hardware = {

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
