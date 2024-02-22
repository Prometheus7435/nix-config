{config, lib, pkgs, ...}:
{
  services.keycloak = {
    enable = true;
    database = {
      type = "postgresql";
      createLocally = true;
      host = "localhost";

      username = "admin";
      passwordFile = "/home/shyfox/code/keycloak_psql_pass";
    };

    settings = {
      hostname = "localhost";
      hostname-strict-backchannel = true;
      http-host = "localhost";
      http-port = 38080;
      proxy = "passthrough";
      http-enabled = true;
    };
    initialAdminPassword = "e6Wcm0RrtegMEHl";  # change on first login
    # sslCertificate = "/run/keys/ssl_cert";
    # sslCertificateKey = "/run/keys/ssl_key";
    # database.passwordFile = "/run/keys/db_password";
  };
}
