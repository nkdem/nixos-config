{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.nkdem = {
    isNormalUser = true;
    home = "/home/nkdem";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "test";
  };

}
