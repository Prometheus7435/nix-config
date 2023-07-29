{config, username, ...}:
let
  nfs_folder = "";

in
{
  # NFS drives
  ## sg1
  fileSystems."/mnt/nfs/zach" = {
    device = "10.10.10.11:/atlantis/nfs/zach";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };

  ## starbase
##   fileSystems."/mnt/nfs/${user}" = {  ## for future
  fileSystems."/mnt/zach" = {
    # device = "starbase.tail0301a.ts.net:/mnt/alpha/nfs/zach";
    device = "10.10.10.12:/mnt/alpha/nfs/zach";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };
}
