{
  description = "Jupyter + Wolfram development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Official Wolfram Research Jupyter-kernel implementation.
    wolfram-language-for-jupyter = {
      url = "github:WolframResearch/WolframLanguageForJupyter";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, wolfram-language-for-jupyter }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkDevShell = system:
        let
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

          wolframKernelBin =
            "${pkgs.wolfram-engine}/bin/WolframKernel";

          kernelScript =
            "${wolfram-language-for-jupyter}/WolframLanguageForJupyter/Resources/KernelForWolframLanguageForJupyter.wl";

          kernelName = "wolframlanguage";

          wolframJupyterKernel = pkgs.writeTextFile {
            name = "wolfram-jupyter-kernelspec";
            destination =
              "/share/jupyter/kernels/${kernelName}/kernel.json";

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
        in
        pkgs.mkShell {
          packages = [
            python
            pkgs.wolfram-engine
            pkgs.gnumake
          ];

          JUPYTER_PATH =
            "${wolframJupyterKernel}/share/jupyter";

          shellHook = ''
            export PS1="(wolfram) $PS1"
          '';
        };
    in
    {
      devShells = forAllSystems (system: {
        default = mkDevShell system;
      });
    };
}
