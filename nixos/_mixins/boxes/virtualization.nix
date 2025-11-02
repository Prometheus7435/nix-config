{ config, pkgs, callPackage, ... }: {
  environment.systemPackages = with pkgs; [
    guestfs-tools
    libguestfs
    libguestfs-appliance
    libguestfs-with-appliance
    libvirt
    # qemu_full
    # qemu-utils
    # quickemu
    spice-gtk
    virt-manager
    virt-viewer
    virtiofsd
  ];
  virtualisation.libvirtd = {
    enable = true;
    # qemu.ovmf.enable = true;
    qemu.vhostUserPackages = [ pkgs.virtiofsd ];
  };

}
