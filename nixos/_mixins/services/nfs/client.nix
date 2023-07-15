# {config, pkgs, ...}:
{config, ...}:
let
  nfs_folder = ""

in
{
  # NFS drives
  ## sg1
  fileSystems."/mnt/nfs/${user}" = {
    device = "10.10.10.11:/atlantis/nfs/zach";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };

  ## starbase
  fileSystems."/mnt/zach" = {
    device = "10.10.10.238:/mnt/alpha/nfs/zach";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };

  # ## Example from NixOS Wiki
  # fileSystems."/export/mafuyu" = {
  #   device = "/mnt/mafuyu";
  #   options = [ "bind" ];
  # };

  # fileSystems."/export/sen" = {
  #   device = "/mnt/sen";
  #   options = [ "bind" ];
  # };

  # fileSystems."/export/tomoyo" = {
  #   device = "/mnt/tomoyo";
  #   options = [ "bind" ];
  # };

  # fileSystems."/export/kotomi" = {
  #   device = "/mnt/kotomi";
  #   options = [ "bind" ];
  # };

  # services.nfs.server.enable = true;
  # services.nfs.server.exports = ''
  #   /export         192.168.1.10(rw,fsid=0,no_subtree_check) 192.168.1.15(rw,fsid=0,no_subtree_check)
  #   /export/kotomi  192.168.1.10(rw,nohide,insecure,no_subtree_check) 192.168.1.15(rw,nohide,insecure,no_subtree_check)
  #   /export/mafuyu  192.168.1.10(rw,nohide,insecure,no_subtree_check) 192.168.1.15(rw,nohide,insecure,no_subtree_check)
  #   /export/sen     192.168.1.10(rw,nohide,insecure,no_subtree_check) 192.168.1.15(rw,nohide,insecure,no_subtree_check)
  #   /export/tomoyo  192.168.1.10(rw,nohide,insecure,no_subtree_check) 192.168.1.15(rw,nohide,insecure,no_subtree_check)
  # '';

  # ## From Ubuntu server
  # /atlantis/nfs                 10.10.10.251(rw,nohide,sync,no_subtree_check)
  # /atlantis/nfs/zach            10.10.10.251(rw,nohide,sync,no_subtree_check)
  # /atlantis/media               10.10.10.251(rw,nohide,sync,no_subtree_check)
  # /atlantis/media/tv            10.10.10.251(rw,nohide,sync,no_subtree_check)
  # /atlantis/iso_holder/media    10.10.10.251(rw,nohide,sync,no_subtree_check)

  # # Desktop
  # /atlantis/nfs/zach             10.10.10.20(rw,nohide,sync,no_subtree_check)
  # /atlantis/iso_holder/media     10.10.10.20(rw,nohide,sync,no_subtree_check)
  # /atlantis/media/tv             10.10.10.20(rw,nohide,sync,no_subtree_check)
  # /atlantis/media/WebShows       10.10.10.20(rw,nohide,sync,no_subtree_check)
}
