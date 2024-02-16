{

  services.nginx = {
    enable = true;

    # enable recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "bombays.cloud" = {
        forceSSL = true;
        enableACME = true;
        locations = {
          "/cloak/" = {
            proxyPass = "http://localhost:${toString config.services.keycloak.settings.http-port}/cloak/";
          };
        };
      };
    };
  };

  services.postgresql.enable = true;

  services.keycloak = {
    enable = true;

    database = {
      type = "postgresql";
      createLocally = true;

      username = "keycloak";
      passwordFile = "/etc/nixos/secrets/keycloak_psql_pass";
    };

    settings = {
      hostname = "bombays.cloud";
      http-relative-path = "/cloak";
      http-port = 38080;
      proxy = "passthrough";
      http-enabled = true;
    };
  };

}
