{
  description = "Cross-platform NixOS flake for bootstrapping Kubernetes control-plane and/or worker nodes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { disko, nixpkgs, ... }:
    let
      roles = [
        "control-plane"
        "worker"
      ];
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      nixosConfigurations = builtins.listToAttrs (
        builtins.concatMap (
          role:
          builtins.map (system: {
            name = "${role}-${system}";
            value = nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                disko.nixosModules.disko
                ./hosts/${role}/configuration.nix
              ];

              specialArgs = {
                pkgs = import nixpkgs { inherit system; };
              };
            };
          }) systems
        ) roles
      );
    in
    {
      inherit nixosConfigurations;
    };
}
