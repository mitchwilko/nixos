{
  description = "Jupyter + Wolfram development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Official Wolfram Research Jupyter-kernel implementation. Not a flake
    # itself; we only need Resources/KernelForWolframLanguageForJupyter.wl
    # out of it. Pinned reproducibly via flake.lock, same as nixpkgs.
    wolfram-language-for-jupyter = {
      url = "github:WolframResearch/WolframLanguageForJupyter";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, wolfram-language-for-jupyter }:
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

    # nixpkgs' wolfram-engine derivation wraps the real binary and exposes
    # it at $out/bin/WolframKernel (sets LD_LIBRARY_PATH etc via makeWrapper).
    wolframKernelBin = "${pkgs.wolfram-engine}/bin/WolframKernel";

    # The exact REPL script the official configure-jupyter.wls points
    # "argv" at — fetched declaratively instead of cloned at shell-start.
    kernelScript =
      "${wolfram-language-for-jupyter}/WolframLanguageForJupyter/Resources/KernelForWolframLanguageForJupyter.wl";

    kernelName = "wolframlanguage";

    # A derivation containing nothing but the kernelspec, laid out the
    # way Jupyter expects: share/jupyter/kernels/<name>/kernel.json
    wolframJupyterKernel = pkgs.writeTextFile {
      name = "wolfram-jupyter-kernelspec";
      destination = "/share/jupyter/kernels/${kernelName}/kernel.json";
      text = builtins.toJSON {
        argv = [
          wolframKernelBin
          "-script"
          kernelScript
          "{connection_file}"
        ];
        display_name = "Wolfram Language";
        language = "Wolfram Language";
      };
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        python
        pkgs.wolfram-engine
        pkgs.gnumake
      ];

      # Jupyter walks every "<entry>/kernels/*/kernel.json" under
      # JUPYTER_PATH, so this is enough for `jupyter kernelspec list` /
      # `jupyter lab` to see the kernel — no `kernelspec install`, no
      # writing to $HOME, fully reproducible from the flake inputs.
      JUPYTER_PATH = "${wolframJupyterKernel}/share/jupyter";

      shellHook = ''
        export PS1="(wolfram) $PS1"
      '';
    };
  };
}
