{ config, pkgs, ... }:
{
  # hardware = {
  #   pulseaudio.enable = false;
  # };

  services = {
    # pulseaudio = {
    #   enable = true;
    # };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
