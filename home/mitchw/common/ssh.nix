# home/mitchw/ssh.nix

{ config, pkgs, ... }:

{
  # Start the ssh key agenet
  services.ssh-agent.enable = true;

  # Enable the SSH program module
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # Manages ~/.ssh/config defaults
    
    settings = {
      "github.com" = {
        Hostname = "ssh.github.com";
        # user = "git";
        Port = 443;
        AddKeysToAgent = "yes";
        IdentityFile = "~/.ssh/id_GITHUB";
      };

      "server.bream-betta.ts.net" = {
        Hostname = "server.bream-betta.ts.net";
        # user = "deploy";
        Port = 222;
        AddKeysToAgent = "yes";
        IdentityFile = "~/.ssh/id_GITEA";
      };

      "mpswpi" = {
        HostName = "pi.bream-betta.ts.net";
        User = "mitchw";
        IdentityFile = "~/.ssh/id_ed25519";
        Port = 20273;
        AddKeysToAgent = "yes";
      };
    };
  };
}
