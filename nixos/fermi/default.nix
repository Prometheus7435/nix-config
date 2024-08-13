# VM for running various services
{ config, inputs, lib, pkgs, username, modulesPath, ... }:{

  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    # inputs.nixos-hardware.nixosModules.common-pc
    # inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../_mixins/hardware/systemd-boot.nix
    ../_mixins/hardware/default.nix
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/network-dhcp.nix
    # (modulesPath + "/installer/scan/not-detected.nix")
    # ../_mixins/containers/pihole.nix
  ];
  boot = {
    # supportedFilesystems = [ "zfs" ];
    # zfs = {
    # };

    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    kernelPackages = pkgs.linuxPackages_latest;  # "should" have the nVidia stuff in it for my card

    kernelParams = [ "mitigations=off" ];

    # blacklistedKernelModules = lib.mkDefault [ "nouveau" ];  # for nVidia cards

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
    # zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    # nvtop
  ];
  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      # "nvidia-settings"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xone.enable = true;

    # nvidia = {
    #   # Modesetting is needed for most wayland compositors
    #   modesetting.enable = true;

    #   prime = {
    #     nvidiaBusId = "PCI:45:0:0";
    #   };

    #   # Use the open source version of the kernel module
    #   # Only available on driver 515.43.04+
    #   # open = true;

    #   # Enable the nvidia settings menu
    #   nvidiaSettings = true;

    #   # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #   # package = config.boot.kernelPackages.nvidiaPackages.stable;
    # };
  };


}
