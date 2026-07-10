# home/mitchw/packages.nix

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    
    # Yazi Previews
    chafa
    ffmpegthumbnailer
    poppler
    jq
    p7zip
    file
    imagemagick

    # Fonts
    nerd-fonts.fira-code
  ];
}
