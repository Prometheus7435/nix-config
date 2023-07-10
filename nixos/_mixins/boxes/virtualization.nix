{ config, pkgs, callPackage, ... }: {
  environment.systemPackages = with pkgs; [
    # virtualization
    libguestfs
    libvirt
    qemu_full
    virt-manager
    quickemu
    spice-gtk
  ];
  virtualisation.libvirtd.enable = true;

}
