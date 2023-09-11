{ ... }: {
  console.keyMap = "us";
  # time.timeZone = "America/New_York";

  services = {
    xserver = {
      layout = "us,dv";
      xkbVariant = "dvorak,";
    };
    automatic-timezoned.enable = true;  # dynamic timezone
  };
  # services.xserver.layout = "us";
  # services.automatic-timezoned.enable = true;  # dynamic timezone
}
