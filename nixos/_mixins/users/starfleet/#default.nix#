{ config, desktop, lib, pkgs, username, ...}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
   # Only include desktop components if one is supplied.
  imports = [
    ./packages-console.nix
  ] ++ lib.optional (builtins.isString desktop) ./packages-desktop.nix;

  users.users.${username} = {
    description = "Server user of starfleet. Are these ever not self-referential?";
    extraGroups = [
      "disk"
      "audio"
      "users"
      "video"
      "wheel"
      "input"
      "systemd-journal"
      "networkmanager"
      "network"
      ]
      ++ ifExists [
        "docker"
        "podman"
        "libvirtd"
      ];
    # mkpasswd -m sha-512
    hashedPassword = "$6$RXjSt1BIOO1FjF7T$PFQb9p3fSICeDKYSRGaK9ibnO2JKg6aklwnjUSXAI8oVzfhr5IJLczhmGPbL4KuxhCw5II2uToio/er7QMgN11";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAAQ0U2dsCJVhcRtFGoo8xAzIXWTlQIEAoKCCn5EQ6v+SrQ8ol871cZO6ZOSc4HfPehE7qO9Kg3VxdXUo5ty4opYFQF7LTJ60xbIb/zNyKVvAb5SNFHmtpNvTrtGZvMNMI7mhRc2BJUQhKH2iXqiLGMRTbKqUuGHil3BigYSz1uqV6Rx6A== zach@phoenix"
    ];
    packages = [ pkgs.home-manager ];
    shell = pkgs.fish;
  };
}
