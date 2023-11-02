{lib, pkgs, ...}:
let
  my-python-packages = ps: with ps; [
    pandas
    requests
    jedi
    black
    jedi-language-server
    pip
  ];
in
{
  environment.systemPackages = with pkgs; [
    ruff
    python3Full
    (python3.withPackages my-python-packages)
  ];
}
