{ ... }: {
  console.keyMap = "us";
  # time.timeZone = "America/New_York";

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "dvorak,";
      xkbOptions = "grp:win_space_toggle";
    };
    automatic-timezoned.enable = true;  # dynamic timezone
  };
  # services.xserver.layout = "us";
  # services.automatic-timezoned.enable = true;  # dynamic timezone
}
