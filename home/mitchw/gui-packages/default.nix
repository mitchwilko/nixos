# home/mitchw/packages.nix

{ pkgs, ... }:

{
  imports = [
    ./alacritty
    ./zarthura
    ./i3
  ];

  home.packages = with pkgs; [
    firefox
    
    # Extended Termianl Applications

    # # Yazi Previews
    # chafa
    # ffmpegthumbnailer
    # poppler
    # jq
    # p7zip
    # file
    # imagemagick

    # Fonts
    # nerd-fonts.fira-code
  ];
}
