{ config, lib, pkgs, modulesPath, ... }: {
#{ config, lib, pkgs, ... }: {
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

#    zfs.forceImportRoot = false;
    supportedFilesystems = [ "zfs" ];
    # zfs.requestEncryptionCredentials = true;

    kernelPackages = pkgs.linuxPackages_zen;
#    kernelParams = [ "mem_sleep_default=deep" ];
    kernelParams = [ "mitigations=off" ];
#    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    extraModulePackages = [];

    kernelModules = [
      "acpi_call"
      "kvm-amd"
      # "vhost_vsock"
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
        # "amdgpu"
      ];
    };
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
