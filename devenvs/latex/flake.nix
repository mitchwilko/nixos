{
  description = "LaTeX development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
  let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f (import nixpkgs { inherit system; }));
  in
  {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          gnumake
          python3
          (texlive.combine {
            inherit (texlive)
              scheme-medium
              latexmk
              bbm
              braket
              physics
              biber
              biblatex;
          })
        ];

        shellHook = ''
          export PS1="(latex) $PS1"
        '';
      };
    });
  };
}
