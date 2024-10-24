## based on Jupiter Broadcasting Nextcloud
{ self, config, lib, pkgs, ... }: {
  # Based on https://carjorvaz.com/posts/the-holy-grail-nextcloud-setup-made-easy-by-nixos/
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "zacharybombay@gmail.com";
      dnsProvider = "cloudflare";
      # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
      # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#EnvironmentFile=
      environmentFile = "/home/shyfox/Zero/nix-config/nixos/_mixins/services/nextcloud/sionnach.txt";
    };
  };
  services = {
    nginx.virtualHosts = {
      "cloud.sionnach.us" = {
        forceSSL = true;
        enableACME = true;
        # Use DNS Challenege.
        acmeRoot = null;
      };
      "onlyoffice.sionnach.us" = {
        forceSSL = true;
        enableACME = true;
        acmeRoot = null;
      };
    };


    nextcloud = {
      enable = true;
      hostName = "cloud.sionnach.us";

      home = "/home/shyfox/code/nextcloudtest";
      # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud29;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size.
      maxUploadSize = "10G";
      https = true;

      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        inherit bookmarks calendar cookbook contacts deck gpoddersync groupfolders notes notify_push onlyoffice previewgenerator qownnotesapi tasks twofactor_webauthn;
      };
      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "US";
        # dbtype = "sqlite";
        dbtype = "mysql";
        adminuser = "admin";
        adminpassFile = "/home/shyfox/Zero/nix-config/nixos/_mixins/services/nextcloud/nextcloud_password.txt";
        # adminpassFile = "../../../../../code/nextcloud-admin-password.txt";  # No spilling secrets today
      };
      # Suggested by Nextcloud's health check.
      phpOptions."opcache.interned_strings_buffer" = "16";
    };
    # Nightly database backups.
    # postgresqlBackup = {
    #   enable = true;
    #   startAt = "*-*-* 01:15:00";
    # };
  };
  environment.systemPackages = [
    # pkgs.mysql

  ];
}
