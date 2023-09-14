{config, ...}:

{
  services.nfs.server = {
  # services.nfs.server.enable = true;
    # services.nfs.server.exports = ''
    enable = true;
    exports = ''
      ## Laptop
      /mnt/alpha/nfs                  10.10.10.251(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/nfs/zach             10.10.10.251(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/media                10.10.10.251(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/media/tv             10.10.10.251(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/iso_holder/media     10.10.10.251(rw,nohide,sync,no_subtree_check)

      ## Desktop - Odyssey
      /mnt/alpha/nfs/zach             10.10.10.20(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/iso_holder/media     10.10.10.20(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/media/tv             10.10.10.20(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/media/movies         10.10.10.20(rw,nohide,sync,no_subtree_check)
      # /mnt/alpha/media/webshows       10.10.10.20(rw,nohide,sync,no_subtree_check)

      ## Akira
      /mnt/alpha/nfs/zach             100.82.110.9(rw,nohide,sync,no_subtree_check)
##      /mnt/alpha/nfs/zach             10.10.10.240(rw,nohide,sync,no_subtree_check)
          '';
  };
}
