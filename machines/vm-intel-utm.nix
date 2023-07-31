{ config, pkgs, modulesPath, ... }: {
  imports = [
    ./vm-shared.nix
  ];

  # Interface is this on my M1
  networking.interfaces.enp0s1.useDHCP = true;

  # Qemu
  services.spice-vdagentd.enable = true;
  services.xserver = {
    displayManager.sessionCommands = ''
        ${pkgs.spice-vdagent}/bin/spice-vdagent
      '';
  };

  # For now, we need this since hardware acceleration does not work.
  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";
}
