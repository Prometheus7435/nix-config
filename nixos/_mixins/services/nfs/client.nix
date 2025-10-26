{config, username, ...}:
let
  nfs_folder = "";
  serverIP = "100.126.182.65";
in
{
  boot.supportedFilesystems = [ "nfs" ];

  fileSystems."/mnt/zach" = {
    device = "${serverIP}:/mnt/alpha/nfs/zach";
    # device = "10.10.10.12:/mnt/alpha/nfs/${username}";    # future config
    fsType = "nfs";
    options = [ "noauto" "user" "x-systemd.automount"];
  };
  fileSystems."/mnt/media" = {
    device = "${serverIP}:/mnt/alpha/media";
    fsType = "nfs";
    options = [ "noauto" "user" "x-systemd.automount"];
    # options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "user"];
  };
}
