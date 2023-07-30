{pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    maliit-keyboard
    wacomtablet

  ];
  hardware = {
    sensor = {
      # automatic screen orientation
      iio = {
        enable = true;
      };
    };
  };
}
