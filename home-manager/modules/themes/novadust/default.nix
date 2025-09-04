## default.nix
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
    # Enable all components by default when novadust is enabled
    novadust = {
      gtk.enable = lib.mkDefault true;
      alacritty.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault (!config.novadust.hyprland.enable);
      wofi.enable = lib.mkDefault config.novadust.hyprland.enable;
    };
    
    home.packages = with pkgs; [
      # Theme tools
      lxappearance
      qt5ct                   
      
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
      
      # Basic utilities
      neofetch
      htop
      tree
      imagemagick
      
      # Essential clipboard and tools
      wl-clipboard         
      xclip               
      playerctl             
      libnotify            
      brightnessctl        
      pavucontrol           
      nautilus              
      
    ] ++ lib.optionals config.novadust.hyprland.enable [
      grim                 
      slurp               
      wf-recorder           
      swww                 
      hyprpicker          
      swaylock-effects     
      swayidle            
      wlr-randr            
   
      
    ] ++ lib.optionals config.novadust.i3.enable [
      # X11 packages
      flameshot             
      scrot                 
      feh                  
      nitrogen              
      picom                 
      arandr               
      xrandr               
      i3lock-color         
      dunst                 
    ];

    # Font configuration
    fonts.fontconfig.enable = true;
  };
}
