{config, pkgs, lib, inputs, ...}: {

services.nextcloud = {
  enable = true;
  package = pkgs.nextcloud27;
  # Instead of using pkgs.nextcloud27Packages.apps,
  # we'll reference the package version specified above
  extraApps = with config.services.nextcloud.package.packages.apps; {
    inherit news contacts calendar tasks;
  };
  extraAppsEnable = true;
  configureRedis = true;
  config = {
    dbtype = "pgsql";
  };
  enableImagemagick = true;
  autoUpdateApps.enable = true;
  datadir = "/mnt/alpha/docker/apps/nextcloud"
};

}
