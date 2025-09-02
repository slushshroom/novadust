## i3.nix - i3 window manager theming module
{ config, pkgs, lib, ... }:

let
  colors = config.novadust.colors;
in
{
  options.novadust.i3.enable = lib.mkEnableOption "Novadust i3 theme";

  config = lib.mkIf config.novadust.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        
        fonts = {
          names = [ "Inter" "Font Awesome 6 Free" ];
          style = "Medium";
          size = 10.0;
        };
        
        colors = {
          focused = {
            border = colors.blue.primary;
            background = colors.blue.primary;
            text = colors.text.primary;
            indicator = colors.blue.light;
            childBorder = colors.blue.primary;
          };
          
          focusedInactive = {
            border = colors.ui.border;
            background = colors.bg.secondary;
            text = colors.text.secondary;
            indicator = colors.ui.border;
            childBorder = colors.ui.border;
          };
          
          unfocused = {
            border = colors.ui.border;
            background = colors.bg.primary;
            text = colors.text.muted;
            indicator = colors.ui.border;
            childBorder = colors.ui.border;
          };
          
          urgent = {
            border = colors.ui.error;
            background = colors.ui.error;
            text = colors.text.primary;
            indicator = colors.ui.error;
            childBorder = colors.ui.error;
          };
          
          placeholder = {
            border = colors.ui.border;
            background = colors.bg.primary;
            text = colors.text.muted;
            indicator = colors.ui.border;
            childBorder = colors.ui.border;
          };
          
          background = colors.bg.primary;
        };

        gaps = {
          inner = 8;
          outer = 4;
          smartGaps = true;
          smartBorders = "on";
        };
        
        window = {
          border = 2;
          titlebar = false;
          hideEdgeBorders = "smart";
        };

        floating = {
          border = 2;
          titlebar = false;
        };

        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
            
            fonts = {
              names = [ "Inter" "Font Awesome 6 Free" ];
              style = "Medium";
              size = 11.0;
            };
            
            trayOutput = "primary";
            
            colors = {
              background = colors.bg.primary;
              statusline = colors.text.primary;
              separator = colors.text.muted;
              
              focusedWorkspace = {
                border = colors.blue.primary;
                background = colors.blue.primary;
                text = colors.text.primary;
              };
              
              activeWorkspace = {
                border = colors.bg.tertiary;
                background = colors.bg.tertiary;
                text = colors.text.primary;
              };
              
              inactiveWorkspace = {
                border = colors.bg.primary;
                background = colors.bg.primary;
                text = colors.text.muted;
              };
              
              urgentWorkspace = {
                border = colors.ui.error;
                background = colors.ui.error;
                text = colors.text.primary;
              };
              
              bindingMode = {
                border = colors.warm.orange;
                background = colors.warm.orange;
                text = colors.text.primary;
              };
            };
          }
        ];

        startup = [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }
        ];
      };
    };
  };
}
