{ config, inputs, lib, pkgs, username, modulesPath, ... }:{

  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../_mixins/hardware/systemd-boot.nix
    ../_mixins/hardware/default.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    (modulesPath + "/installer/scan/not-detected.nix")
    # ../_mixins/containers/pihole.nix
  ];
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs = {
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    kernelParams = [ "mitigations=off" ];

    # kernelPackages = pkgs.linuxPackages;
    extraModulePackages = [];

    kernelModules = [
      "acpi_call"
      "vhost_vsock"
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
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [

  ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xone.enable = true;
  };
}
