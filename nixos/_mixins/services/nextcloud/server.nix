{config, pkgs, lib, ...}: {

services.nextcloud = {
  enable = true;
  package = pkgs.nextcloud27;
  # Instead of using pkgs.nextcloud27Packages.apps,
  # we'll reference the package version specified above
  extraApps = with config.services.nextcloud.package.packages.apps; {
    inherit bookmarks calendar contacts deck keeweb news notes onlyoffice tasks twofactor_webauthn;
  };
  extraAppsEnable = true;
  configureRedis = true;
  config = {
    dbtype = "pgsql";
  };
  enableImagemagick = true;
  autoUpdateApps.enable = true;
  datadir = "/mnt/alpha/docker/apps/nextcloud";
  home = "/mnt/alpha/docker/apps/nextcloud";
  # notify_push.enable = true;
};

}
