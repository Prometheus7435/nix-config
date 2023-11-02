{ pkgs, username, ... }:
{

  environment.systemPackages = [
     pkgs.nextcloud-client
  ];
}
