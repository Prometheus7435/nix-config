# { disks ? [ "/dev/nvme0n1" ], ... }:
{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/nvme0n1";
        # device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = {
            ESP = {
              size = "256M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          compression = "lz4";
          encryption = "on";
          keylocation = "prompt";
          keyformat = "passphrase";
          "com.sun:auto-snapshot" = "false";
          recordsize = "1M";
          # primarycache = "metadata"; # test field
          atime = "off";
        };
        mountpoint = "/";
        postCreateHook = "zfs snapshot zroot@initial";

        options = {
          ashift = "12";
          autotrim = "off";
        };
        datasets = {

        };
      };
    };
  };
}
