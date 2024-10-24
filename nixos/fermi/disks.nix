{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/vdb";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
# {
#   disko.devices = {
#     disk = {
#       sda = {
#         type = "disk";
#         device = "/dev/vdb";
#         # device = builtins.elemAt disks 0;
#         content = {
#           type = "table";
#           format = "gpt";
#           partitions = [
#             {
#               name = "ESP";
#               start = "0";
#               end = "256MiB";  # way overkill because I'm tired of getting errors because I ran out of space
#               fs-type = "fat32";
#               bootable = true;
#               content = {
#                 type = "filesystem";
#                 format = "vfat";
#                 mountpoint = "/boot";
#               };
#             }
#             {
#               name = "zfs";
#               start = "265MiB";
#               end = "100%";
#               content = {
#                 type = "zfs";
#                 pool = "zroot";
#               };
#             }
#           ];
#         };
#       };
#     };
#     zpool = {
#       zroot = {
#         type = "zpool";
# #        mode = "mirror";
#         rootFsOptions = {
#           compression = "lz4";
#           "com.sun:auto-snapshot" = "false";
#         };
#         mountpoint = "/";
#         postCreateHook = "zfs snapshot zroot@blank";

#         datasets = {

#         };
#       };
#     };
#   };
# }
