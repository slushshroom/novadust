{
  description = "Novadust - Dark blue theme for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    # This matches your existing default.nix structure
    homeManagerModules = {
      default = ./home-manager/modules/themes/novadust;
      novadust = ./home-manager/modules/themes/novadust;
    };
  };
}
