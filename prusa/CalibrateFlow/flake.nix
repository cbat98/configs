{
  description = "Python3 + pip";

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
	pkgs.python311Full
        pkgs.python311Packages.tkinter
      ];

      shellHook = ''
        echo "Hello, Python!"
      '';
    };
  };
}
