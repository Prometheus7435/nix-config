{lib, pkgs, ...}:
let
  my-python-packages = ps: with ps; [
    pandas
    requests
    jedi
    black
    jedi-language-server
    pip
    yt-dlp

  ];
in
{
  environment.systemPackages = with pkgs; [
    ruff
    # python3Full
    (python312.withPackages my-python-packages)
    # (python3.withPackages(ps:
    #   with ps; [
    #     pandas requests yt-dlp numpy
    #   ]
    # ))
    # virtualenv
  ];
}
