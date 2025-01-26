{ config, inputs, lib, pkgs, username, modulesPath, ... }: {
  imports = [
    # inputs.nixos-hardware.nixosModules.common-gpu-amd
    # inputs.nixos-hardware.nixosModules.common-gpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../_mixins/hardware/default.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/systemd-boot.nix

    ../_mixins/desktop/creative.nix

    ../_mixins/services/media-edit.nix
    ../_mixins/services/pipewire.nix

    ../_mixins/containers/default.nix
    # ../_mixins/boxes/virtualization.nix

    # ../_mixins/services/nfs/client.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
#    zfs.forceImportRoot = false;
    # supportedFilesystems = [ "zfs" ];
    # supportedFilesystems = [ "zfs" ];
    # zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_zen;
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    # kernelParams = [ "mitigations=off" ];
    extraModulePackages = [];
    blacklistedKernelModules = lib.mkDefault [ "nouveau" ];
    kernelModules = [
      "kvm-amd"
      # "nvidia"
      # "amdgpu"
      # "vhost_vsock"
    ];

    initrd = {
      availableKernelModules = [
        # "sd_mod"
      ];
      kernelModules = [

      ];
    };
  };

  swapDevices = [ ];

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

  environment.systemPackages = with pkgs; [
    nvtop  # top like program for gpus
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

  services = {
    fstrim.enable = true;
  };
}
