{
  description = "NixOS systems and tools by nkdem";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      
      # We want to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable }@inputs: let
    mkVM = import ./lib/mkvm.nix;
    unstableOverlay = final: prev: {
      unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
    overlays = [ unstableOverlay ];
  in {
    nixosConfigurations.vm-intel-utm = mkVM "vm-intel-utm" rec {
      inherit nixpkgs home-manager overlays;
      system = "x86_64-linux";
      user   = "nkdem";
    };
  };
}
