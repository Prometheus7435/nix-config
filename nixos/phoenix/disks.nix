# { disks ? [ "/dev/nvme0n1" ], ... }:
{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/nvme0n1";
        # device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          # type = "table";
          # format = "gpt";
          partitions = [
          # partitions = {
            # ESP = {
              name = "ESP";
              size = "256MiB";
              # start = "0";
              # end = "256MiB";  # way overkill because I'm tired of getting errors because I ran out of space
              # fs-type = "fat32";
              # bootable = true;
              type = "EF00";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            # };
            {
            # zfs = {
              name = "zfs";
              # start = "260MiB";
              # end = "100%";
              size = "100%";
              priority = 2;
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          # };
          ];
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
          primarycache = "metadata"; # test field
          atime = "off";
        };
        mountpoint = "/";
        postCreateHook = "zfs snapshot zroot@blank";

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
