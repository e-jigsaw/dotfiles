{
  description = "My Darwin Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    darwinConfigurations."JigsawStudio" = nix-darwin.lib.darwinSystem {
      modules = [
        ./configuration.nix
      ];
      specialArgs = { inherit self; };
    };
  };
}