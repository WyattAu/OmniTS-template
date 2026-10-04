{
  # OmniTS dev environment — nix owns system tools, bun owns JS packages
  # (bun.lock stays the pin everyone shares).
  description = "OmniTS-template development environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            bun
            nodejs_22 # playwright + astro check prefer a system node
            git
          ];

          shellHook = ''
            echo "OmniTS: bun $(bun --version) / node $(node --version)"
            echo "playwright browsers: bunx playwright install (once per host)"
          '';
        };
      });
    };
}
