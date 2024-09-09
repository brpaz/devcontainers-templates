{
  description = "Dev envrionment for dev container templates";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            hadolint
            shellcheck
            devcontainer
            go-task
          ];

          shellHook = ''
            echo "Hello from Nix"
          '';
        };
      }
    );
}