{ config, pkgs, ... }:

{
  # Network linker
  # system.activationScripts.NextcloudNetwork =
  #   let
  #     backend = config.virtualisation.oci-containers.backend;
  #     backendBin = "${pkgs.${backend}}/bin/${backend}";
  #   in
  #   ''
  #     ${backendBin} network create nextcloud-net --subnet 172.20.0.0/16 || true
  #   '';

  # Database
  virtualisation.oci-containers.containers = {
    "nextcloud-db" = {
      autoStart = true;
      image: "postgres:alpine";
      volumes = [
        "/mnt/vmpool/nextcloud/nextcloud-db:/var/lib/postgresql/data"
      ];
      # ports = [
      # ];
      environment = {
        POSTGRES_PASSWORD=nextcloud;  # bad, bad coder. Do it proper
        POSTGRES_DB=nextcloud;
        POSTGRES_USER=nextcloud;
      };
    };

    "redis" = {
      autoStart = true;
      image = "redis:alpine"
    };

    "nextcloud" = {
      autoStart = true;
      image = {
        "nextcloud:apache"
      };
      ports = [
        "127.0.0.1:8080:80"
      ];
      volumes = [
        "/mnt/alpha/containers/Nextcloud/data:/var/www/html"
      ];
      environment = {
        POSTGRES_HOST=db;
        REDIS_HOST=redis;
        POSTGRES_PASSWORD=nextcloud;  # I am a bad thing
        POSTGRES_DB=nextcloud;
        POSTGRES_USER=nextcloud;
      };
      dependsOn = [ "nextcloud-db" "redis" ];
    };

    "cron" = {
      autoStart = true;
      image = "nextcloud:apache";
      volumes = [
        "/mnt/alpha/containers/Nextcloud/data:/var/www/html"
      ];
      dependsOn = [ "nextcloud-db" "redis" ];
    };

    # "nextcloud-db" = {
    #   autoStart = true;
    #   image = "mariadb:10.5";
    #   cmd = [ "--transaction-isolation=READ-COMMITTED" "--binlog-format=ROW" ];
    #   volumes = [
    #     "/mnt/vmpool/nextcloud/nextcloud-db:/var/lib/mysql"
    #   ];
    #   ports = [ "3306:3306" ];
    #   environment = {
    #     MYSQL_ROOT_PASSWORD = "nextcloud";
    #     MYSQL_PASSWORD = "nextcloud";
    #     MYSQL_DATABASE = "nextcloud";
    #     MYSQL_USER = "nextcloud";
    #   };
    #   extraOptions = [ "--network=nextcloud-net" ];
    # };

    # # NextCloud
    # # virtualisation.oci-containers.containers.
    # "nextcloud" = {
    #   autoStart = true;
    #   image = "nextcloud";
    #   ports = [ "8089:80" ];
    #   environment = {
    #     MYSQL_PASSWORD = "nextcloud";
    #     MYSQL_DATABASE = "nextcloud";
    #     MYSQL_USER = "nextcloud";
    #     MYSQL_HOST = "nextcloud-db";
    #   };
    #   dependsOn = [ "nextcloud-db" ];
    #   volumes = [
    #     "/mnt/alpha/containers/Nextcloud/data:/var/www/html"
    #   ];
    #   extraOptions = [ "--network=nextcloud-net" ];
    # };
  };
}
