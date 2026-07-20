_: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 7;
      systemd-boot.enable = true;
      systemd-boot.memtest86.enable = false;
      timeout = 5;
    };
  };
}
