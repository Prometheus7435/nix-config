{lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    ccid
    gnupg-pkcs11-scd
    pciutils
    pcsclite
    pcsctools
    opensc
    libcacard
    openct
    acsccid
    cardpeek
  ];

  services = {
    pcscd.enable = true;
    locate.enable = true;
  };
}
