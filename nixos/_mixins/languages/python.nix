{lib, pkgs, ...}:
let
  my-python-packages = ps: with ps; [
    pandas
    requests
    jedi
    black
    jedi-language-server
  ];
in
{
  environment.systemPackages = with pkgs; [
    python3
    (python3.withPackages my-python-packages)
  ];
}
