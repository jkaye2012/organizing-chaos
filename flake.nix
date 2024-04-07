{
  description = "Thoughts on technical leadership and software engineering";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    neovim.url = "github:jkaye2012/neovim-flake";
    # neovim.url = "/home/jkaye/git/neovim-flake";
  };

  outputs = { self, nixpkgs, flake-utils, neovim }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          jkvim = neovim.packages.${system};
        in
          {
            devShells.default = import ./shell.nix { inherit pkgs jkvim; };
          }
      );
}
