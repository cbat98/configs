{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
	pkgs.openssl
      ];

      shellHook = ''
        export OMP_DISABLE=0
        echo "OpenSSL Shell"
      '';
    };
  };
}

