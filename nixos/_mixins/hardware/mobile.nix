{pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    # maliit-keyboard
    # wacomtablet
  ];

  # powerManagement.enable = true;
  # services = {
  #   # xserver.libinput.enable = true;
  #   tlp = {
  #     settings = {
  #       START_CHARGE_THRESH_BAT0 = "60";
  #       STOP_CHARGE_THRESH_BAT0 = "85";
  #     };
  #   };
  # };

  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {

    };
    sensor = {
      # automatic screen orientation
      iio = {
        enable = true;
      };
    };
  };
}
