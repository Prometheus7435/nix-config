{lib, pkgs, config, ...}:

# version: "3"

# # More info at https://github.com/pi-hole/docker-pi-hole/ and https://docs.pi-hole.net/
# services:
#   pihole:
#     container_name: pihole
#     image: pihole/pihole:latest
#     # For DHCP it is recommended to remove these ports and instead add: network_mode: "host"
#     ports:
#       - "53:53/tcp"
#       - "53:53/udp"
#       - "67:67/udp" # Only required if you are using Pi-hole as your DHCP server
#       - "80:80/tcp"
#     environment:
#       TZ: 'America/Chicago'
#       # WEBPASSWORD: 'set a secure password here or it will be random'
#     # Volumes store your data between container upgrades
#     volumes:
#       - './etc-pihole:/etc/pihole'
#       - './etc-dnsmasq.d:/etc/dnsmasq.d'
#     #   https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
#     cap_add:
#       - NET_ADMIN # Required if you are using Pi-hole as your DHCP server, else not needed
#     restart: unless-stopped

{
  # Pi-Hole
  virtualisation.oci-containers.containers."pihole" = {
    autoStart = true;
    image = "pihole/pihole:latest";
    environment = {
      USER_UID = "1000";
      USER_GID = "1000";
      TZ = "America/New_York";
      WEBPASSWORD = "changeMeOrElse";
    };
    volumes = [
      "/home/fermi/pihole/etc-pihole:/etc/pihole"
      "home/fermi/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
    ];
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "80:80/tcp"
    ];
  };

}
