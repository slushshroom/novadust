## gtk.nix - GTK theming module
{ config, pkgs, ... }:

{
  options.novadust.gtk.enable = pkgs.lib.mkEnableOption "Novadust GTK theme";

  config = pkgs.lib.mkIf config.novadust.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      
      cursorTheme = {
        name = "Numix-Cursor";
        package = pkgs.numix-cursor-theme;
        size = 24;
      };

      gtk2.extraConfig = ''
        gtk-theme-name="Adwaita-dark"
        gtk-icon-theme-name="Papirus-Dark"
        gtk-font-name="Inter 11"
        gtk-cursor-theme-name="Numix-Cursor"
        gtk-cursor-theme-size=24
        gtk-toolbar-style=GTK_TOOLBAR_BOTH
        gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
        gtk-button-images=1
        gtk-menu-images=1
        gtk-enable-event-sounds=1
        gtk-enable-input-feedback-sounds=1
      '';

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = true;
        gtk-cursor-theme-name = "Numix-Cursor";
        gtk-cursor-theme-size = 24;
        gtk-decoration-layout = "appmenu:minimize,maximize,close";
        gtk-enable-animations = true;
        gtk-font-name = "Inter 11";
        gtk-icon-theme-name = "Papirus-Dark";
        gtk-menu-images = true;
        gtk-primary-button-warps-slider = false;
        gtk-theme-name = "Adwaita-dark";
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-cursor-theme-name = "Numix-Cursor";
        gtk-cursor-theme-size = 24;
        gtk-decoration-layout = "appmenu:minimize,maximize,close";
        gtk-enable-animations = true;
        gtk-font-name = "Inter 11";
        gtk-icon-theme-name = "Papirus-Dark";
        gtk-primary-button-warps-slider = false;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita-dark";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Numix-Cursor";
        cursor-size = 24;
        font-name = "Inter 11";
        document-font-name = "Inter 11";
        monospace-font-name = "JetBrains Mono 10";
        color-scheme = "prefer-dark";
      };
    };
  };
}
