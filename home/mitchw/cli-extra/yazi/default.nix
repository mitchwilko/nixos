# home/mitchw/yazi/deault.nix

{ ... }:

{
  programs.yazi = {
    enable = true;
  };

  home.file.".config/yazi".source = ./.;
}
