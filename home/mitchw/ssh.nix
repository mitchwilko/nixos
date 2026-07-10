# home/mitchw/ssh.nix

{ config, pkgs, ... }:

{
  # Enable the ssh agentt
  programs.ssh.startAgent = true;

  # Enable the SSH program module
  programs.ssh = {
    enable = true;
    enableDefaultConfig = true; # Manages ~/.ssh/config defaults
    
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        # user = "git";
        port = 443;
        addKeysToAgent = 'yes'
        identityFile = "~/.ssh/id_GITHUB";
      };

      "server.bream-betta.ts.net" = {
        hostname = "server.bream-betta.ts.net";
        # user = "deploy";
        port = 222;
        addKeysToAgent = 'yes'
        identityFile = "~/.ssh/id_GITEA";
      };
    };
  };
}
