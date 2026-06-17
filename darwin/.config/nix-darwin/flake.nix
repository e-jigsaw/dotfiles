{
  description = "My Darwin Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-unstable を使うので nixvim も unstable 追従の main に合わせる
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, nixvim }:
  let
    # nixvim ベースの Neovim パッケージを system ごとにビルドする
    mkNvim = system:
      nixvim.legacyPackages.${system}.makeNixvimWithModule {
        pkgs = nixpkgs.legacyPackages.${system};
        module = ./nvim;
      };

    # standalone 配布対象 (Mac + リモート Linux)
    nvimSystems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
    forNvimSystems = nixpkgs.lib.genAttrs nvimSystems;
  in
  {
    darwinConfigurations."JigsawStudio" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/common.nix
        ./modules/neovim.nix
        ./hosts/JigsawStudio.nix
      ];
      specialArgs = { inherit self; nvim = mkNvim "aarch64-darwin"; };
    };
    darwinConfigurations."Iris" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/common.nix
        ./modules/neovim.nix
        ./hosts/Iris.nix
      ];
      specialArgs = { inherit self; nvim = mkNvim "aarch64-darwin"; };
    };

    # `nix run github:e-jigsaw/dotfiles?dir=darwin/.config/nix-darwin#nvim` でリモートへ撒く
    packages = forNvimSystems (system: rec {
      nvim = mkNvim system;
      default = nvim;
    });

    apps = forNvimSystems (system: rec {
      nvim = {
        type = "app";
        program = "${mkNvim system}/bin/nvim";
      };
      default = nvim;
    });
  };
}
