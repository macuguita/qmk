{
  description = "Keychron Q1 HE QMK development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = nixpkgs.lib.systems.flakeExposed;
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };

          qmkSrc = pkgs.fetchgit {
            url = "https://github.com/Keychron/qmk_firmware.git";

            rev = "4efcc8c9bf87687c9004079743c80d9a023d531c";

            hash = "sha256-VF7bWFf+KtbPSNUyjl4D+r10MYlmRfFE8VH0Uq6VoU4=";

            fetchSubmodules = true;
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              qmk
              git
              gnumake
              python3
              gcc-arm-embedded
              dfu-util
              libusb1
              unzip
              wget
              which

              nixfmt
            ];
            shellHook = ''
              export QMK_SRC="${qmkSrc}"

              echo "QMK source:"
              echo "  $QMK_SRC"
            '';
          };
        }
      );
    };
}
