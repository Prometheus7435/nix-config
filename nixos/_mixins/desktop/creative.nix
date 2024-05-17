{ pkgs, ... }: {
  # Desktop application momentum follows the unstable channel.
  # programs = {
  #   firefox = {
  #     enable = true;
  #     package = pkgs.unstable.firefox;
  #   };
  # }

  environment.systemPackages = with pkgs; [
    blender
    # gimp-with-plugins
    krita
    inkscape
    darktable
    digikam
    # openscad
    # freecad
    # solvespace
  ];
}
