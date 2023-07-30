{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
in {
  imports = [ ./direnv.nix ];

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs.jq
    pkgs.ripgrep
    pkgs.tree
    pkgs.firefox
    pkgs.rofi
    pkgs.vscode
    pkgs.xorg.xev
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

  home.file.".gdbinit".source = ./gdbinit;
  home.file.".inputrc".source = ./inputrc;

  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
  xdg.configFile."devtty/config".text = builtins.readFile ./devtty;


  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

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

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };

      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        extensions = with pkgs.vscode-extensions; [
            # ayu-theme.vscode-ayu
            bbenoist.nix
            mkhl.direnv
            rust-lang.rust-analyzer
            # github.copilot
        ];
        userSettings = {
            "telemetry.telemetryLevel" = "off";
            "workbench.colorTheme" = "Ayu Mirage Bordered";
            "workbench.sideBar.location" = "right";
            "editor.fontFamily" = "Iosevka";
            "editor.fontLigatures" = true;
            "editor.fontSize" = 15;
            "editor.fontWeight" = "500";
            "window.zoomLevel" = 0.5;
            "terminal.integrated.fontSize" = 15;
            "editor.titleBar.enabled" = false;
        };
    };
}
