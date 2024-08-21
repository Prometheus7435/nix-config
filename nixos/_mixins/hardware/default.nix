{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    ../services/fwupd.nix
  ];

  boot = {
    kernelParams = [ ];
  };

  hardware = {
    graphics = {
    # opengl = {
      enable = true;
      extraPackages = with pkgs; [
        # intel-media-driver # LIBVA_DRIVER_NAME=iHD
        # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for FF/Chromium)
        # vaapiVdpau
        # libvdpau-va-gl
        # intel-ocl
        # rocm-opencl-icd
      ];
      # driSupport = true;
      # driSupport32Bit = true;
    };
  };

  services = {
    # auto-cpufreq.enable = true;
    # fwupd.enable = true;
  };
}
