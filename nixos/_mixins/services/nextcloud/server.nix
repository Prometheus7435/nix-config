# {config, pkgs, lib, ...}: {

#   services.nextcloud = {
#     enable = true;
#     package = pkgs.nextcloud27;
#     hostName = "localhost";
#     # Instead of using pkgs.nextcloud27Packages.apps,
#     # we'll reference the package version specified above
#     extraApps = with config.services.nextcloud.package.packages.apps; {
#       inherit bookmarks calendar contacts deck keeweb news notes onlyoffice tasks twofactor_webauthn;
#     };
#     extraAppsEnable = true;
#     configureRedis = true;
#     # caching.redis = true;
#     config = {
#       adminpassFile = "/etc/nextcloud-admin-pass.json";
#       dbtype = "pgsql";
#     };
#     # enableImagemagick = true;
#     autoUpdateApps.enable = true;
#     # datadir = "/mnt/alpha/docker/apps/nextcloud";
#     home = "/mnt/alpha/docker/apps/nextcloud";
#     # notify_push.enable = true;

#     secretFile = "/etc/nextcloud-secrets.json";

#     # extraOptions = {
#     #   redis = {
#     #     host = "/run/redis/redis.sock";
#     #     port = 0;
#     #     dbindex = 0;
#     #     password = "secret";
#     #     timeout = 1.5;
#     #   };
#     # };
#   };
#   environment.etc."nextcloud-admin-pass".text = "SuperSecret";
#   environment.etc."nextcloud-secrets.json".text = ''
#   {
#     "passwordsalt": "SuperSecret",
#     "secret": "SuperSecret",
#     "redis": {
#       "password": "SuperSecret"
#     }
#   }
# '';
# }


## based on Jupiter Broadcasting Nextcloud
{ self, config, lib, pkgs, ... }: {
  # Based on https://carjorvaz.com/posts/the-holy-grail-nextcloud-setup-made-easy-by-nixos/
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "prometheus7435@yahoo.com";
      dnsProvider = "porkbun";
      # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
      # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#EnvironmentFile=
      environmentFile = "/REPLACE/WITH/YOUR/PATH";
    };
  };
  services = {
    nginx.virtualHosts = {
      "bombays.cloud" = {
        forceSSL = true;
        enableACME = true;
        # Use DNS Challenege.
        acmeRoot = null;
      };
    };
    #
    nextcloud = {
      enable = true;
      hostName = "bombays.cloud";
      # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud28;
      # Let NixOS install and configure the database automatically.
      database.createLocally = true;
      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;
      # Increase the maximum file upload size.
      maxUploadSize = "16G";
      https = true;
      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        inherit calendar contacts notes onlyoffice tasks cookbook qownnotesapi;
        # Custom app example.
        # socialsharing_telegram = pkgs.fetchNextcloudApp rec {
        #   url =
        #     "https://github.com/nextcloud-releases/socialsharing/releases/download/v3.0.1/socialsharing_telegram-v3.0.1.tar.gz";
        #   license = "agpl3";
        #   sha256 = "sha256-8XyOslMmzxmX2QsVzYzIJKNw6rVWJ7uDhU1jaKJ0Q8k=";
        # };
      };
      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "US";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/REPLACE/WITH/YOUR/PATH";
      };
      # Suggested by Nextcloud's health check.
      phpOptions."opcache.interned_strings_buffer" = "16";
    };
    # Nightly database backups.
    postgresqlBackup = {
      enable = true;
      startAt = "*-*-* 01:15:00";
    };
  };
}
