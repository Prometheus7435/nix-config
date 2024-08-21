{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    ../services/fwupd.nix
  ];

  boot = {
    kernelParams = [ ];
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
  };

  services = {
    # auto-cpufreq.enable = true;
  };
}
