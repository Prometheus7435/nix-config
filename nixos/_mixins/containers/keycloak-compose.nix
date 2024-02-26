{config, pkgs, ...}: {

  # Gitea
  virtualisation.oci-containers.containers."tailscale" = {
    autoStart = true;
    image = "tailscale/tailscale:latest";
    environment = {
      USER_UID = "1000";
      USER_GID = "1000";
    };
    volumes = [
      - "./tailscale_var_lib:/var/lib"        # State data will be stored in this directory
      - "/dev/net/tun:/dev/net/tun"
    ];
    cap_add = [
      - "net_admin"
      - "sys_module"
    ];
    command = tailscaled;
    # ports = [
    #   "3000:3000"
    #   "222:22"
      # ];

  };

}
