#home/mitchw/gui-packages/zarthura

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (zathura.override {
      plugins = with zathuraPkgs; [
        zathura_pdf_mupdf # For PDF support
        zathura_cb        # For Comic book support (optional)
      ];
    })
  ];
}
