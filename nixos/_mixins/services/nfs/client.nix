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
    device = "10.10.10.12:/mnt/alpha/nfs/zach";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  };
}
