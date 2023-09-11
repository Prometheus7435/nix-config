{ config, lib, pkgs, modulesPath, hostname, hostid, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
#    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.supermicro
    ../_mixins/services/pipewire.nix
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/systemd-boot.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    # loader = {
    #   systemd-boot = {
    #     enable = true;
    #     configurationLimit = 10;
    #     memtest86 = {
    #       enable = true;
    #     };
    #   };
    #   efi = {
    #     canTouchEfiVariables = true;
    #   };
    #   timeout = 3;
    # };

    supportedFilesystems = [ "zfs" ];
    zfs = {
      extraPools = [ "vmpool" "alpha"];
      requestEncryptionCredentials = true;
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    kernelParams = [ "mitigations=off" ];
#    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    # extraModulePackages = [];

    # kernelModules = [
    #   # "kvm-intel"
    #   "acpi_call"
    #   "kvm-amd"
    #   "vhost_vsock"
    # ];

    initrd = {
      # availableKernelModules = [
      #   "xhci_pci"
      #   "ehci_pci"
      #   "ahci"
      #   "usbhid"
      #   "usb_storage"
      #   "sd_mod"
      #   "virtio_balloon"
      #   "virtio_blk"
      #   "virtio_pci"
      #   "virtio_ring"
      #   "mpt3sas"
      #   "nvme"
      # ];
      kernelModules = [
        "amdgpu"
      ];
    };
  };

  swapDevices = [ ];

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  networking = {
    hostName = hostname;
    hostId = hostid;
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = false;
    };
    macvlans = {
      iot = {
        interface = "enp132s0f0";
        mode = "bridge";
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    # nvtop  # top like program for gpus
  ];

  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    # opengl = {
    #   enable = true;
    #   driSupport = true;
    #   driSupport32Bit = true;
    # };
    xone.enable = true;
  };
}
