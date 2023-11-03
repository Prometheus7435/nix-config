{ pkgs, inputs, username, ... }:
{
  environment.systemPackages = [
     pkgs.nextcloud-client
  ];
  # services.nextcloud-client = {
  #   enable = true;
  #   startInBackground = true;
  # };
}
