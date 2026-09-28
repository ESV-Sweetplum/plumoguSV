{
  description = "Development environment and Quaver plugin packages for plumoguSV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    self.submodules = true;
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          version = (builtins.fromJSON (builtins.readFile ./package.json)).version;
          releaseName = "plumoguSV-${version}";
          nodeModules = pkgs.importNpmLock.buildNodeModules {
            npmRoot = self;
            nodejs = pkgs.nodejs_22;
          };
          plugin = pkgs.stdenv.mkDerivation {
            pname = "plumogu-sv";
            inherit version;
            src = self;

            nativeBuildInputs = [ pkgs.nodejs_22 pkgs.typescript pkgs.unzip ];

            buildPhase = ''
              runHook preBuild
              cp -r ${nodeModules}/node_modules .
              chmod -R u+w node_modules
              # Luaver must finish writing settings.ini before packaging it.
              substituteInPlace Luaver/src/build.ts \
                --replace-fail 'writeSettingsIni(luaverConfig.buildVersionInPluginName);' \
                  'await writeSettingsIni(luaverConfig.buildVersionInPluginName);'
              tsc -b
              mkdir -p builds
              node dist/build.js
              runHook postBuild
            '';

            doCheck = true;
            checkPhase = ''
              runHook preCheck
              test -s "builds/${releaseName}.zip"
              unzip -t "builds/${releaseName}.zip"
              test -s "builds/${releaseName}-steam/plugin.lua"
              test -s "builds/${releaseName}-steam/settings.ini"
              runHook postCheck
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p "$out/share/quaver/Plugins" "$out/share/plumoguSV"
              unzip -q "builds/${releaseName}.zip" -d "$out/share/quaver/Plugins"
              cp "builds/${releaseName}.zip" "$out/share/plumoguSV/"
              cp -r "builds/${releaseName}-steam" "$out/share/plumoguSV/"
              runHook postInstall
            '';

            meta = {
              description = "SV editing plugin for Quaver";
              homepage = "https://github.com/ESV-Sweetplum/plumoguSV";
              license = pkgs.lib.licenses.gpl3Only;
              platforms = systems;
            };
          };
        in
        { default = plugin; });

      checks = forAllSystems (system: { default = self.packages.${system}.default; });

      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            packages = [ pkgs.nodejs_22 pkgs.typescript pkgs.stylua ];
          };
        });
    };
}
