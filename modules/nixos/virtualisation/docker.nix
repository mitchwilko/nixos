# modules/virtualisation/docker.nix

{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;

    # Optional
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
