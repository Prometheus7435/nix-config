{config, pkgs, lib, ...}: {

services.nextcloud = {
  enable = true;
  package = pkgs.nextcloud27;
  hostName = "nextcloud.bombay.cloud";
  # Instead of using pkgs.nextcloud27Packages.apps,
  # we'll reference the package version specified above
  extraApps = with config.services.nextcloud.package.packages.apps; {
    inherit bookmarks calendar contacts deck keeweb news notes onlyoffice tasks twofactor_webauthn;
  };
  extraAppsEnable = true;
  # configureRedis = true;
  caching.redis = true;
  config = {
    dbtype = "pgsql";
  };
  enableImagemagick = true;
  autoUpdateApps.enable = true;
  datadir = "/mnt/alpha/docker/apps/nextcloud";
  home = "/mnt/alpha/docker/apps/nextcloud";
  notify_push.enable = true;
  extraOptions = {
    redis = {
         host = "/run/redis/redis.sock";
         port = 0;
         dbindex = 0;
         password = "secret";
         timeout = 1.5;
    };
  };
};

}
