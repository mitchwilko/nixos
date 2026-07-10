# home/mitchw/packages.nix

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    moonlight-qt
    
    # Yazi Previews
    chafa
    ffmpegthumbnailer
    poppler
    jq
    p7zip
    file
    imagemagick
  ];
}
