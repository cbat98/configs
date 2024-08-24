{
  description = "Development Applications";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.neovim
	pkgs.vim
	pkgs.wget
	pkgs.cowsay
      ];

      shellHook = ''
        echo "Hello, world!"
      '';
    };
  };
}
