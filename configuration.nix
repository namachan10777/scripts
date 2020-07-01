# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    <nixos-hardware/lenovo/thinkpad/x280>
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config

  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp59s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod.enabled = "fcitx";
  i18n.inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  fonts = {
    fonts = [
      pkgs.ipafont
      pkgs.hack-font
      pkgs.siji
      pkgs.fixedsys-excelsior
      pkgs.unifont
      pkgs.iosevka
      pkgs.nerdfonts
    ];
    fontconfig.defaultFonts = {
      serif = [ "IPAPMincho" ];
      sansSerif = [ "IPAGothic" ];
      monospace = [ "DejaVu Sans Mono" ];
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    firefox
    fish
    alacritty
    stack
    pavucontrol
    networkmanager
    rofi
    picom
    exa
    lazygit
    xsel
    gnumake
    gcc
    m4
  ];
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    layout = "jp";
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
      config = ''
        import XMonad
        import System.IO
        import XMonad.Layout.NoFrillsDecoration
        import XMonad.Hooks.DynamicLog
        import XMonad.Hooks.ManageDocks
        import XMonad.Util.Run(spawnPipe)
        import XMonad.Layout.ResizableTile
        import XMonad.Layout.Spacing
        import XMonad.Util.NamedWindows(getName)
        import XMonad.Hooks.EwmhDesktops(fullscreenEventHook, ewmh)
        import XMonad.Util.EZConfig
        import System.Directory
        import System.Posix.Files
        import Data.List
        import Data.Ord
        import Control.Monad
        import qualified XMonad.StackSet as S


        main :: IO()
        main = do
            workspaceLogfile <- return "/tmp/.xmonad-workspace-log"
            titleLogfile <- return "/tmp/.xmonad-title-log"
            prepareLogFile workspaceLogfile
            prepareLogFile titleLogfile
            xmonad $ ewmh $ docks def
                { terminal    = "alacritty"
                , borderWidth = 3
                , startupHook = myStartupHook
                , layoutHook = myLayout
                , modMask = myModMask
                , logHook = eventLogHook workspaceLogfile titleLogfile
                }
               `additionalKeys`
               [ ((myModMask .|. controlMask, xK_l     ), spawn "light-locker-command -l")
               , ((myModMask, xK_Print) , spawn "gnome-screenshot")
               , ((myModMask, xK_p) , spawn "rofi -show drun")
               , ((myModMask, xK_F5) , spawn "xbacklight -dec 10")
               , ((myModMask, xK_F6) , spawn "xbacklight -inc 10") ]

        prepareLogFile :: [Char] -> IO()
        prepareLogFile name = do
            de <- doesFileExist name
            case de of
                True -> return ()
                _    -> createNamedPipe name stdFileMode
            return ()

        getWorkspaceLog :: X String
        getWorkspaceLog = do
              winset <- gets windowset
              let currWs = S.currentTag winset
              let wss    = S.workspaces winset
              let wsIds  = map S.tag   $ wss
              let wins   = map S.stack $ wss
              let (wsIds', wins') = sortById wsIds wins
              return . (foldl (\acc id -> (fmt currWs wins' id) ++ " " ++ acc) " ") . reverse $ wsIds'
              where
                 hasW = not . null
                 idx = flip (-) 1 . read
                 sortById ids xs = unzip $ sortBy (comparing fst) (zip ids xs)
                 fmt cw ws id
                      | id == cw            = " \63022"
                      | hasW $ ws !! idx id = " \61842"
                      | otherwise           = " \63023"

        getTitleLog :: X String
        getTitleLog = do
            winset <- gets windowset
            title <- maybe (return "") (fmap show . getName) . S.peek $ winset
            return title

        eventLogHook :: FilePath -> FilePath -> X ()
        eventLogHook workspaceLog titleLog = do
            io . appendFile workspaceLog . (++ "\n") =<< getWorkspaceLog
            io . appendFile titleLog . (++ "\n") =<< getTitleLog

        myStartupHook = do
            spawn "feh --bg-scale /usr/share/lightdm-webkit/themes/litarvan/img/background.b9890328.png"
            spawn "picom -c -D 5"
            spawn "fcitx"
            spawn "polybar example"
            spawn "slack"
            spawn "light-locker"
            spawn "xautolock -time 1 -locker \"light-locker-command -l\" -notify 10 -notifier \"notify-send -t 5000 -i gtk-dialog-info 'Locking in 10 seconds'"

        myModMask = mod4Mask -- Superkey

        myLayout = avoidStruts $ smartSpacing sp (Mirror (tall) ||| tall) ||| Full
            where
                tall = ResizableTall 1 (0.03) (0.7) []
        sp = 6
      '';
    };
    displayManager.lightdm.enable = true;
  };
  # services.xserver.enable = true;
  # services.xserver.layout = "jp106";
  # services.xserver.xkbOptions = "eurosign:e";
  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.namachan = {
    isNormalUser = true;
    home = "/home/namachan";
    description = "Masaki Nakano";
    extraGroups =
      [ "wheel" "audio" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
  hardware.pulseaudio.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

