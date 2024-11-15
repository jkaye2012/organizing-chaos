{
  description = "Thoughts on technical leadership and software engineering";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    devenv.url = "github:jkaye2012/devenv";
  };

  outputs =
    {
      self,
      nixpkgs,
      devenv,
    }:
    devenv.lib.forAllSystems nixpkgs (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.${system}.default = pkgs.mkShell {
          name = "organizing-chaos";
          inputsFrom = [ devenv.devShells.${system}.default ];
          packages = with pkgs; [ hugo ];
        };
      }
    );
}
