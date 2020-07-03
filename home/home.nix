{ config, pkgs, ... }:
{
  services.polybar = {
    enable = true;
    script = "polybar example &";
    package = pkgs.stdenv.mkDerivation rec {
      pname = "polybar";
      version = "3.4.3";

      src = pkgs.fetchFromGitHub {
        owner = pname;
        repo = pname;
        rev = version;
        sha256 = "0fsfh3xv0c0hz10xqzvd01c0p0wvzcnanbyczi45zhaxfrisb39w";
        fetchSubmodules = true;
      };

      meta = with pkgs.stdenv.lib; {
        homepage = "https://polybar.github.io/";
        description = "A fast and easy-to-use tool for creating status bars";
        longDescription = ''
          Polybar aims to help users build beautiful and highly customizable
          status bars for their desktop environment, without the need of
          having a black belt in shell scripting.
        '';
        license = licenses.mit;
        maintainers = with maintainers; [ afldcr filalex77 ];
        platforms = platforms.linux;
      };

      buildInputs = [
        pkgs.cairo pkgs.xorg.libXdmcp pkgs.xorg.libpthreadstubs pkgs.xorg.libxcb pkgs.pcre pkgs.python3 pkgs.xorg.xcbproto pkgs.xorg.xcbutil
        pkgs.xorg.xcbutilcursor pkgs.xorg.xcbutilimage pkgs.xorg.xcbutilrenderutil pkgs.xorg.xcbutilwm pkgs.xcbutilxrm
        pkgs.libpulseaudio
        pkgs.coreutils
      ];

      nativeBuildInputs = [
        pkgs.cmake pkgs.pkgconfig pkgs.removeReferencesTo
      ];
      postFixup = ''
          remove-references-to -t ${pkgs.stdenv.cc} $out/bin/polybar
      '';
    };
    extraConfig = builtins.readFile ./config/polybar_config;
  };
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      env.EDITOR = "nvim";
      window.padding = {
        x = 8;
        y = 4;
      };
      background_opacity = 0.7;
      font = {
        normal.family = "Hack";
        bold.family = "Hack";
        italic.family = "Hack";
        bold_italic.family = "Hack";
        size = 7.2;
      };
    };
  };
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-nix
      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "vim-commitita-2020-07-01";
        src = pkgs.fetchgit {
          url = "https://github.com/rhysd/committia.vim";
          rev = "2cded48477a5e308c77a0d289cc9b540669b701f";
          sha256 = "1g6ykdh7d16q6nvpvmxx4ss8w7cisx5r8qmbrrvhpwmbb3894pxp";
        };
        dependencies = [];
      })
    ];
    extraConfig = builtins.readFile ./config/init.vim;
  };
  programs.starship = { enable = true; };
  programs.fish = {
    plugins = [{
      name = "fish-ghq";
      src = pkgs.fetchFromGitHub {
        owner = "decors";
        repo = "fish-ghq";
        rev = "66722b711f0e59625c2b7fa8df1a3592313e7697";
        sha256 = "0rmcrdvxvs9i3fdbp7cnc7yjxdrg0i4qqzgfbanz26r0r19gvk77";
      };
    }];
    enable = true;
    shellAbbrs = {
      v = "nvim";
      gpo = "git push origin";
      lg = "lazygit";
    };
    shellAliases = {
      ll = "exa -l";
      lt = "exa -T";
      clipb = "xsel --clipboard --input";
    };
  };
  programs.bash = {
    enable = true;
    bashrcExtra = "exec fish";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "namachan";
  home.homeDirectory = "/home/namachan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
