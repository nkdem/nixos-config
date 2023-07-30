{ pkgs, ... }:

{
  programs.zsh.enable = true;
  services.gnome = {
      gnome-keyring.enable = true; 
  };

  users.users.nkdem = {
    isNormalUser = true;
    home = "/home/nkdem";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "test";
  };

}
