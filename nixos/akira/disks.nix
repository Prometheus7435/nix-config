{ disks ? [ "/dev/nvme0n1" ], ... }: {
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "0";
              end = "2048MiB";
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
              start = "2100MiB";
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
        rootFsOptions = {
          compression = "lz4";
          encryption = "on";
          keylocation = "prompt";
          keyformat = "passphrase";
          "com.sun:auto-snapshot" = "false";
        };
        mountpoint = "/";
        postCreateHook = "zfs snapshot zroot@blank";

        datasets = {
        #   encrypted = {
        #     type = "zfs_fs";
        #     options = {
        #       mountpoint = "none";
        #       encryption = "aes-256-gcm";
        #       keyformat = "passphrase";
        #       keylocation = "file:///tmp/secret.key";
        #     };
        # };
        };
      };
    };
  };
}
