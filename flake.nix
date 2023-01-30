{
  inputs = {
    nixpkgs.follows = "ghc-wasm-meta/haskell-nix/nixpkgs";
    flake-utils.follows = "ghc-wasm-meta/haskell-nix/flake-utils";
    ghc-wasm-meta.url = "gitlab:amesgen/ghc-wasm-meta?host=gitlab.haskell.org";
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ inputs.ghc-wasm-meta.packages.${system}.default ];
        };
      });
}
