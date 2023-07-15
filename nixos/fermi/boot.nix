{ config, lib, pkgs, modulesPath, ... }: {

  imports = [
    ../_mixins/containers/pihole.nix
  ]
#{ config, lib, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        # memtest86 = {
        #   enable = true;
        # };
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 2;
    };

    kernelPackages = pkgs.linuxPackages;
    # kernelParams = [ "mitigations=off" ];
    extraModulePackages = [];

    kernelModules = [
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
        # "nvme"
      ];
      kernelModules = [

      ];
    };
  };

  # services = {
  #   fstrim.enable = true;
  # };
}
