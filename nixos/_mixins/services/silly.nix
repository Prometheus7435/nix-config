{ config, inputs, lib, pkgs, ... }:

{
  imports = [

  ];

  # Just a bunch of silly packages that will make you smile

  environment.systemPackages = with pkgs; [
    cbonsai
    cowsay
    fortune
    cmatrix
  ];
}
