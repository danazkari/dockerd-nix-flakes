{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      config = {
        users = {
          users = {
            dprado = {
              extraGroups = [ "docker" ];
            };
          };
        };
        virtualisation = {
          docker = {
            rootless = {
              enable = true;
              setSocketVariable = true;
            };
            enable = true;
            enableOnBoot = true;
          };
        };
      };
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          docker
        ];
        shellHook = ''
          docker run --rm hello-world
        '';
      };
    }
  );
}
