{
  description = "A development environment for the sipgate ruby gem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        rubyVersionName = builtins.getEnv "RUBY_VERSION";
        actualRubyVersionName = if rubyVersionName == "" then "ruby_3_1" else rubyVersionName;
        ruby = pkgs.${actualRubyVersionName};
        bundler = pkgs.bundler;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            ruby
            bundler
            pkgs.git
            pkgs.sqlite
          ];

          shellHook = ''
            export GEM_HOME="$(pwd)/.gems"
            export PATH="$GEM_HOME/bin:$PATH"
            bundle install
          '';
        };
      });
}