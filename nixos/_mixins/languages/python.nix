{lib, pkgs, ...}: {
  let
    my-python-packages = ps: with ps; [
      pandas
      requests
      jedi
      black
      jedi-language-server
      # other python packages
    ];
  in
    environment.systemPackages = with pkgs; [
      python3Full
      (python3Full.withPackages my-python-packages)
    ];

}
