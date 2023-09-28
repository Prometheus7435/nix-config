{ config, pkgs, callPackage, ... }: {
  environment.systemPackages = with pkgs; [
    # virtualization
    libguestfs
    guestfs-tools
    libguestfs-with-appliance
    libguestfs-appliance
    libvirt
    qemu_full
    virt-manager
    virt-viewer
    quickemu
    spice-gtk
    virtiofsd
  ];
  virtualisation.libvirtd.enable = true;

}
