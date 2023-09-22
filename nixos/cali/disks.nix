# enp132s0f0

## Straight copy from Whimpy's vm config
{ disks ? [ "/dev/vda" ], ... }:
let
  defaultXfsOpts = [ "defaults" "relatime" "nodiratime" ];
in
{
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [{
            name = "boot";
            start = "0%";
            end = "1M";
            flags = [ "bios_grub" ];
          }
            {
              name = "ESP";
              start = "1M";
              end = "550MiB";
              bootable = true;
              flags = [ "esp" ];
              fs-type = "fat32";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "root";
              start = "560MiB";
              end = "100%";
              content = {
                type = "filesystem";
                # Overwirte the existing filesystem
                extraArgs = [ "-f" ];
                format = "xfs";
                mountpoint = "/";
                mountOptions = defaultXfsOpts;
              };
            }];
        };
      };
    };
  };
}
# {
#   disko.devices = {
#     disk = {
#       vda = {
#         device = "/dev/vda";
#         type = "disk";
#         content = {
#           type = "gpt";
#           partitions = {
#             # name = "ESP";
#             # start = "0";
#             # end = "512MiB";  # way overkill because I'm tired of getting errors because I ran out of space
#             # fs-type = "fat32";
#             # bootable = true;
#             # content = {
#             #   type = "filesystem";
#             #   format = "vfat";
#             #   mountpoint = "/boot";
#             ESP = {
#               type = "EF00";
#               size = "500M";
#               content = {
#                 type = "filesystem";
#                 format = "vfat";
#                 mountpoint = "/boot";
#               };
#             };
#             root = {
#               size = "100%";
#               content = {
#                 type = "filesystem";
#                 format = "ext4";
#                 mountpoint = "/";
#               };
#             };
#           };
#         };
#       };
#     };
#   };
# }
