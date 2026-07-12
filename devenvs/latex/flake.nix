# Wolfram Jupter Notebook

{
  description = "Jupyter + Wolfram development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    python = pkgs.python3.withPackages (ps: with ps; [
      jupyterlab
      ipykernel

      numpy
      scipy
      matplotlib
      pandas
      sympy
    ]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        python
        pkgs.wolfram-engine
        pkgs.gnumake
        pkgs.libgcc
      ];

      shellHook = ''
        echo "Entering Jupyter/Wolfram Environment"
        export PS1="(wolfram) $PS1"
      '';
    };
  };
}
