{config, ...}:

{
  services.nfs.server = {
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

      ## Odyssey
      /mnt/alpha/nfs/zach             100.78.103.103(rw,nohide,sync,no_subtree_check)
          '';
    settings = {
      nfsd.udp = false;
      nfsd.vers3 = false;
      nfsd.vers4 = true;
      nfsd."vers4.0" = false;
      nfsd."vers4.1" = false;
      nfsd."vers4.2" = true;
    };
  };
}
