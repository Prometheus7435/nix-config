{config, ...}:

{
  services.nfs.server = {
  # services.nfs.server.enable = true;
    # services.nfs.server.exports = ''
    enable = true;
    exports = ''
      ## Desktop - Windows
        ## 100.109.81.2
        ## 10.107.0.10
      /mnt/alpha/iso_holder/media     10.107.0.10(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/media/tv             10.107.0.10(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/media/movies         10.107.0.10(rw,nohide,sync,no_subtree_check)
      /mnt/alpha/nfs/zach             10.107.0.10(rw,nohide,sync,no_subtree_check)

      ## Phoenix
      /mnt/alpha/nfs/zach             100.123.61.88(rw,nohide,sync,no_subtree_check)
          '';
  };
}
