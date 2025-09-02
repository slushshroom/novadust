## Example home.nix usage:
{ config, pkgs, ... }:

{
  imports = [
    ./modules/themes/novadust
  ];

  # For Hyprland users - enable the full suite with Hyprland
  novadust = {
    enable = true;
    hyprland.enable = true;  # This will automatically enable wofi instead of rofi
  };
  
  # For i3 users - enable with i3
  # novadust = {
  #   enable = true;
  #   i3.enable = true;      # This will use rofi by default
  # };
  
  # Or enable individual components:
  # novadust = {
  #   gtk.enable = true;
  #   alacritty.enable = true;
  #   hyprland.enable = true;  # Enable if using Hyprland
  #   wofi.enable = true;      # Wayland app launcher
  #   # rofi.enable = true;    # X11 app launcher
  # };

  # Your personal configuration
  home = {
    username = "yourusername";      # Replace with your username
    homeDirectory = "/home/yourusername";  # Replace with your home directory
    stateVersion = "23.11";
  };
  
  programs.home-manager.enable = true;
  
  # Optional: Enable additional programs
  programs = {
    git = {
      enable = true;
      userName = "Your Name";
      userEmail = "your.email@example.com";
    };
    
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "sudo" "docker" "kubectl" ];
      };
    };
    
    firefox = {
      enable = true;
      # You can add Firefox theming here later
    };
    
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # The Novadust VSCode theme can be installed manually
        # or you can add other dark themes here
        dracula-theme.theme-dracula
      ];
    };
  };
  
  # Optional: Set up some useful services
  services = {
    # Enable if using GNOME keyring
    gnome-keyring.enable = true;
    
    # Auto-mount USB drives
    udiskie.enable = true;
  };
}
