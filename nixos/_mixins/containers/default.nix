{config, pkgs, ...}:

{
  imports = [
    # ./nextcloud.nix
    # ./gitea.nix
    # ./jellyfin.nix
  ];

  virtualisation = {
    # docker = {
    #   enable = true;
    # };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # oci-containers = {
    #   backend = "podman";

    #   containers = {
    #     # gitea = import ./gitea.nix;
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    # docker-compose
    podman
  ];

  # systemd.services.create-podman-network = with config.virtualisation.oci-containers; {
  #   serviceConfig.Type = "oneshot";
  #   wantedBy = [ "${backend}-homer.service" "${backend}-caddy.service" ];
  #   script = ''
  #     ${pkgs.podman}/bin/podman network exists net_macvlan || \
  #       ${pkgs.podman}/bin/podman network create --driver=macvlan --gateway=192.168.xx.1 --subnet=192.168.xx.0/24 -o parent=ens18 net_macvlan
  #   '';
  # };

  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}
