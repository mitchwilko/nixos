# home/mitchw/bash/default.nix

{ ... }:

{
  programs.bash = {
    enable = true;

    bashrcExtra = ''
      source ${./bashrc}
    '';
  };
}
