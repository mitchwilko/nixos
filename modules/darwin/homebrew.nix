# hosts/mpswmacbook/homebrew.nix
{ ... }:

{
  homebrew = {
    enable = true;

    casks = [
      # "raycast"
      # "ghostty"
      # "obsidian"
    ];

    brews = [
      # packages that you specifically want from Homebrew
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
