{ config, pkgs, lib, ... }:

{
  imports = [
    ./colors.nix
    ./gtk.nix
    ./alacritty.nix
    ./i3.nix
    ./rofi.nix
    ./hyprland.nix
    ./wofi.nix
  ];

  options.novadust.enable = lib.mkEnableOption "Novadust theme suite";

  config = lib.mkIf config.novadust.enable {
    # Enable components based on window manager
    novadust = {
      gtk.enable = lib.mkDefault true;
      alacritty.enable = lib.mkDefault true;
      # Only enable rofi if hyprland is not enabled
      rofi.enable = lib.mkDefault (!config.novadust.hyprland.enable);
      # Only enable wofi if hyprland is enabled
      wofi.enable = lib.mkDefault config.novadust.hyprland.enable;
    };
    
    home.packages = with pkgs; [
      # Theme tools
      lxappearance
      qt5ct                   
      
      # Fonts (verified packages)
      jetbrains-mono
      fira-code
      inter
      noto-fonts
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      
      # Icon and cursor themes
      papirus-icon-theme
      numix-cursor-theme
      
      # Basic utilities
      neofetch
      htop
      tree
      imagemagick
      
      # Clipboard and media tools
      wl-clipboard         # Wayland clipboard
      xclip               # X11 clipboard
      playerctl           # Media control
      libnotify           # Notifications
      brightnessctl       # Brightness control
      pavucontrol         # Audio control
      
      # File manager
      gnome.nautilus      # Fixed package path
      
    ] ++ lib.optionals config.novadust.hyprland.enable [
      # Wayland-specific packages
      grim                # Screenshots
      slurp               # Screen region selection
      wf-recorder         # Screen recording
      swww                # Wallpaper daemon
      hyprpicker          # Color picker
      swaylock-effects    # Screen locker
      swayidle            # Idle daemon
      wlr-randr           # Display management
      
    ] ++ lib.optionals config.novadust.i3.enable [
      # X11-specific packages
      flameshot           # Screenshots
      scrot               # Screenshots
      feh                 # Image viewer/wallpaper
      nitrogen            # Wallpaper manager
      picom               # Compositor
      arandr              # Display GUI
      xorg.xrandr         # Display management
      i3lock-color        # Screen locker
      dunst               # Notifications
    ];

    # Font configuration
    fonts.fontconfig.enable = true;
  };
}
