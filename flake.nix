{
  description = "DockYard Academy";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        installScript = pkgs.writeShellScriptBin "installScript" ''
        if [ ! -f $MIX_HOME/escripts/livebook ]; then
          mix do local.rebar --force --if-missing
          mix do local.hex --force --if-missing
          mix escript.install --force hex livebook
        fi
        '';
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            installScript
            beam.interpreters.erlangR25
            beam.packages.erlangR25.elixir_1_14
          ];
          shellHook = ''
              export MIX_HOME=$PWD/.nix_mix
              export HEX_HOME=$PWD/.nix_hex
              export PATH=$MIX_HOME/bin:$PATH
              export PATH=$HEX_HOME/bin:$PATH
              export PATH=$MIX_HOME/escripts:$PATH
              export LIVEBOOK_HOME=$PWD
              mkdir -p .nix_mix
              mkdir -p .nix_hex
              installScript
            '';
        };
      }
    );
}
