# home/mitchw/tmux/default.nix

{ ... }:

{
  programs.tmux = {
    enable = true;
  };

  home.file.".config/tmux".source = ./.;
}
