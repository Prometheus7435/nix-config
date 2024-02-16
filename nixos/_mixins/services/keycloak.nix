{config, lib, pkgs, ...}:
{

  # services.nginx = {
  #   enable = true;

  #   # enable recommended settings
  #   recommendedGzipSettings = true;
  #   recommendedOptimisation = true;
  #   recommendedTlsSettings = true;
  #   recommendedProxySettings = true;

  #   virtualHosts = {
  #     "domain.tld" = {
  #       forceSSL = true;
  #       enableACME = true;
  #       security.acme.acceptTerms = true;
  #       locations = {
  #         "/cloak/" = {
  #           proxyPass = "http://localhost:${toString config.services.keycloak.settings.http-port}/cloak/";
  #         };
  #       };
  #     };
  #   };
  # };

  # services.postgresql.enable = true;

  # services.keycloak = {
  #   enable = true;

  #   database = {
  #     type = "postgresql";
  #     createLocally = true;

  #     username = "keycloak";
  #     passwordFile = "/etc/nixos/secrets/keycloak_psql_pass";
  #   };

  #   settings = {
  #     hostname = "domain.tld";
  #     http-relative-path = "/cloak";
  #     http-port = 38080;
  #     proxy = "passthrough";
  #     http-enabled = true;
  #   };
  # };

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
      hostname-strict-backchannel = true;
    };
    initialAdminPassword = "e6Wcm0RrtegMEHl";  # change on first login
    sslCertificate = "/run/keys/ssl_cert";
    sslCertificateKey = "/run/keys/ssl_key";
    # database.passwordFile = "/run/keys/db_password";
  };
}
