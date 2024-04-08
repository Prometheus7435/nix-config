{config, pkgs, ...}: {
  imports = [

  ];

  virtualisation = {
    docker = {
      # enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   defaultNetwork.settings.dns_enabled = true;
    # };

    # oci-containers = {
    #   backend = "podman";

    #   containers = {
    #     # gitea = import ./gitea.nix;
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
