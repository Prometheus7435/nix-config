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
      environmentFile = "../../../../../code/porkbun-api.txt"; # why do I need relative instead of absolute paths?
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
        inherit bookmarks calendar cookbook contacts deck gpoddersync groupfolders notes notify_push onlyoffice previewgenerator qownnotesapi tasks twofactor_webauthn;
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
        adminpassFile = "../../../../../code/nextcloud-admin-password.txt";
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
