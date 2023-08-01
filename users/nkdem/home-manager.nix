{ config, lib, pkgs, ... }:

{
  imports = [ ./direnv.nix ];

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "23.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs.firefox
    pkgs.rofi
    pkgs.gnome.gnome-keyring
    pkgs.unstable.vscode
    pkgs.nil # nix-lsp
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_GB.UTF-8";
    LC_CTYPE = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
  };

  home.shellAliases = {
    refresh-display = "xrandr --output Virtual-1 --auto"; # For QEMU VMs
  };

  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
  xdg.configFile."devtty/config".text = builtins.readFile ./devtty;


  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.zsh = {
      enable = true;
  };

  programs.git = {
    enable = true;
    userName = "nkdem";
    userEmail = "contact@nkdem.net";
    extraConfig = {
      github.user = "nkdem";
      push.default = "tracking";
      init.defaultBranch = "main";
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty;
  };

  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      color_good = "#8C9440";
      color_bad = "#A54242";
      color_degraded = "#DE935F";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
    };
  };

  programs.vim = {
    enable = true;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
