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
    initialHashedPassword = "$y$j9T$7SxCjszO7O.4smU/mz3Vb1$3ZDkknPnj3dK9vgxFBTZIFKuwvjqLxKkifF0ZmD1Ig8";
  };

}
