# { disks ? [ "/dev/vdb" ], ... }:

{
  disko.devices = {
    disk = {
      sda = {
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
              end = "512MiB";  # way overkill because I'm tired of getting errors because I ran out of space
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
              start = "520MiB";
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



# {
#   disk = {
#     vdb = {
#       type = "disk";
#       device = "/dev/sda";
#       # device = builtins.elemAt disks 0;
#       content = {
#         type = "table";
#         format = "gpt";
#         partitions = [
#           {
#             type = "partition";
#             name = "ESP";
#             start = "1MiB";
#             end = "512MiB";
#             bootable = true;
#             content = {
#               type = "filesystem";
#               format = "vfat";
#               mountpoint = "/boot";
#             };
#           }
#           {
#             name = "root";
#             type = "partition";
#             start = "513MiB";
#             end = "100%";
#             part-type = "primary";
#             bootable = true;
#             content = {
#               type = "filesystem";
#               format = "ext4";
#               mountpoint = "/";
#             };
#           }
#         ];
#       };
#     };
#   };
# }
