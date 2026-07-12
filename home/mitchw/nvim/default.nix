# home/mitchw/nvim/default.nix

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      oil-nvim
      mini-icons
      render-markdown-nvim
  
      # Dependencies
      nvim-treesitter
    ];
  };

  home.file.".config/nvim".source = ./.; 
}
