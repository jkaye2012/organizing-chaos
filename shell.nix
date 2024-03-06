{ pkgs ? import (fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz"; sha256 = "0sjapzwnf4j41qqi9yj7fmbbafa9642zhfqdhp5mfyp14a6zj55b"; }) {}}:


pkgs.mkShell {
  name = "organizing-chaos";
  packages = [
    pkgs.hugo
  ];
}
