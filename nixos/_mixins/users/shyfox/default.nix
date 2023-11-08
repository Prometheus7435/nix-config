{ config, desktop, lib, pkgs, username, ...}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
   # Only include desktop components if one is supplied.
  imports = [
    ./packages-console.nix
    ../../services/nfs/client.nix
  ] ++ lib.optional (builtins.isString desktop) ./packages-desktop.nix;

  users.users.${username} = {
    description = "Zach";
    extraGroups = [
        "audio"
        "networkmanager"
        "network"
        "users"
        "video"
        "wheel"
        "disk"
        "input"
        "systemd-journal"
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
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAFYfJZwjC4Xdiwopc86qil1WqlLKIEyqhITphQ6ACinR/Bf15RPElPyNVkvv2GiAVhv7mmoQifZWdf0+NlxNNDpfwDT16YDmMCxB01JfrEq21Ml3P4zPAxZHoLmffc7ARKHjD8XYyibWG5Bu0AjzSfq4IDnRBEBx4JY4PAm4lSyKAfFmg== zach@phoenix"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOFJ0JftYliH/rZWkx2YLWx69pFGmSJdUNKaeTqaO//2 zach@phoenix"
    ];
    packages = [ pkgs.home-manager ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
}
