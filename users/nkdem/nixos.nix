{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.nkdem = {
    isNormalUser = true;
    home = "/home/nkdem";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "test";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKw5k/IE4Ky36nkLT0glzb/gH7Rtn8jRpKiIhUSisVZC contact@nkdem.net"
    ];
  };

}
