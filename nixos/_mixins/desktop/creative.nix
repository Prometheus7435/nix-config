{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    blender
    krita
    inkscape
    darktable
    digikam
  ];
}
