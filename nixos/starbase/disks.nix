# { disks ? [ "/dev/sda" ], ... }:
{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/sda";
        # device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "0";
              end = "1024MiB";  # way overkill because I'm tired of getting errors because I ran out of space
              fs-type = "fat32";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "zfs";
              start = "1064MiB";
              end = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            }
          ];
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
#        mode = "mirror";
        rootFsOptions = {
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
        };
        mountpoint = "/";
        postCreateHook = "zfs snapshot zroot@blank";

        datasets = {

        };
      };
    };
  };
}
