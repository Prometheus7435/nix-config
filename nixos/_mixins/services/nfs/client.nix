{config, username, ...}:
let
  nfs_folder = "";

in
{
  # NFS drives
  ## sg1
  # fileSystems."/mnt/nfs/zach" = {
  #   device = "10.10.10.11:/atlantis/nfs/zach";
  #   fsType = "nfs";
  #   options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  # };

  ## from starbase
##   fileSystems."/mnt/nfs/${username}" = {  ## for future
  fileSystems."/mnt/zach" = {
    device = "100.126.182.65:/mnt/alpha/nfs/zach";
    # device = "starbase.tail0301a.ts.net:/mnt/alpha/nfs/zach";
    # device = "10.10.10.12:/mnt/alpha/nfs/${username}";    # future config
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "user" "nfsvers=4.2"];
  };
  fileSystems."/mnt/media" = {
    device = "100.126.182.65:/mnt/alpha/media";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "user" "nfsvers=4.2"];
  };
}
