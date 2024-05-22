{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    ../services/fwupd.nix
  ];

  boot = {
    kernelParams = [ ];
    # extraModulePackages = with config.boot.kernelPackages; [
    #   acpi_call
    # ];

    # kernelModules = [
    #   "acpi_call"
    # ];

    # initrd = {
    #   availableKernelModules = [
    #     "rtsx_pci_sdmmc"
    #     "xhci_pci"
    #     "ehci_pci"
    #     "ahci"
    #     "usbhid"
    #     "usb_storage"
    #     # "sd_mod"
    #     "virtio_balloon"
    #     "virtio_blk"
    #     "virtio_pci"
    #     "virtio_ring"
    #     "mpt3sas"
    #     "nvme"
    #   ];
    #   kernelModules = [

    #   ];
    # };
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        # intel-media-driver # LIBVA_DRIVER_NAME=iHD
        # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for FF/Chromium)
        # vaapiVdpau
        # libvdpau-va-gl
        # intel-ocl
        # rocm-opencl-icd
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    auto-cpufreq.enable = true;
    # fwupd.enable = true;
  };
}
