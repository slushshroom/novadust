## default.nix - Main module file that imports all submodules
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

  # You can add any shared configuration here
  options.novadust.enable = lib.mkEnableOption "Novadust theme suite";

  config = lib.mkIf config.novadust.enable {
    # Enable all components by default when novadust is enabled
    novadust = {
      gtk.enable = lib.mkDefault true;
      alacritty.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault (!config.novadust.hyprland.enable);  # Use rofi for X11
      wofi.enable = lib.mkDefault config.novadust.hyprland.enable;     # Use wofi for Wayland
      # Window managers are left false by default - enable the one you use
      # i3.enable = lib.mkDefault false;
      # hyprland.enable = lib.mkDefault false;
    };
    
    # Install common packages needed for theming
    home.packages = with pkgs; [
      # Theme tools
      lxappearance
      qt5ct
      qt6ct
      
      # Fonts
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
      
      # Utilities
      neofetch
      htop
      tree
      
      # Image manipulation (for wallpaper generation)
      imagemagick
    ];
  };
}
