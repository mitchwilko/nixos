#home/mitchw/gui-packages/zarthura

{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;

    package = pkgs.zathura.override {
      plugins = with pkgs.zathuraPkgs; [
        zathura_pdf_mupdf
        zathura_cb
      ];
    };

    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      smooth-scroll = true;
    };

    mappings = {
      "<C-j>" = "scroll down";
      "<C-k>" = "scroll up";
    };
  };
}
