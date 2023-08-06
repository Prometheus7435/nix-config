{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    # ../_mixins/containers/nextcloud.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        memtest86 = {
          enable = true;
        };
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 3;
    };

    supportedFilesystems = [ "zfs" ];
    zfs = {
      extraPools = [ "vmpool" "alpha"];
      requestEncryptionCredentials = true;
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    # kernelPackages = pkgs.linuxPackages;
#    kernelParams = [ "mem_sleep_default=deep" ];
    kernelParams = [ "mitigations=off" ];
#    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    extraModulePackages = [];

    kernelModules = [
      # "kvm-intel"
      "acpi_call"
      "kvm-amd"
      "vhost_vsock"
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "virtio_balloon"
        "virtio_blk"
        "virtio_pci"
        "virtio_ring"
        "mpt3sas"
        "nvme"
      ];
      kernelModules = [
        "amdgpu"
      ];
    };
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
