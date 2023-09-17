# enp132s0f0
{
  disko.devices = {
    disk = {
      vda = {
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # name = "ESP";
            # start = "0";
            # end = "512MiB";  # way overkill because I'm tired of getting errors because I ran out of space
            # fs-type = "fat32";
            # bootable = true;
            # content = {
            #   type = "filesystem";
            #   format = "vfat";
            #   mountpoint = "/boot";
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
