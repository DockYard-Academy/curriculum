{
  description = "DockYard academy";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            erlang
            elixir
          ];
          shellHook = ''
              mkdir -p .nix_mix
              mkdir -p .nix_hex
              export MIX_HOME=$PWD/utils/.nix_mix
              export HEX_HOME=$PWD/utils/.nix_hex
              export PATH=$MIX_HOME/bin:$PATH
              export PATH=$HEX_HOME/bin:$PATH
              export PATH=$MIX_HOME/escripts:$PATH
              export LIVEBOOK_HOME=$PWD
            '';
        };
      }
    );
}
