## i3.nix
{ config, pkgs, lib, ... }:

{
  options.novadust.i3.enable = lib.mkEnableOption "Novadust i3 theme";

  config = lib.mkIf config.novadust.i3.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;  # VERIFIED to exist
      
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        
        fonts = {
          names = [ "Inter" ];
          size = 10.0;
        };
        
        # Simplified color scheme with direct values
        colors = {
          focused = {
            border = "#4a9eff";
            background = "#4a9eff";
            text = "#e6edf3";
            indicator = "#6bb6ff";
            childBorder = "#4a9eff";
          };
          unfocused = {
            border = "#30363d";
            background = "#0d1421";
            text = "#7d8590";
            indicator = "#30363d";
            childBorder = "#30363d";
          };
          urgent = {
            border = "#f85149";
            background = "#f85149";
            text = "#e6edf3";
            indicator = "#f85149";
            childBorder = "#f85149";
          };
          background = "#0d1421";
        };

        # Simple gaps configuration
        gaps = {
          inner = 8;
          outer = 4;
        };
        
        window = {
          border = 2;
          titlebar = false;
        };

        # Simple status bar (no complex config)
        bars = [{
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "Inter" ];
            size = 11.0;
          };
          colors = {
            background = "#0d1421";
            statusline = "#e6edf3";
            separator = "#7d8590";
            focusedWorkspace = {
              border = "#4a9eff";
              background = "#4a9eff";
              text = "#e6edf3";
            };
            inactiveWorkspace = {
              border = "#0d1421";
              background = "#0d1421";
              text = "#7d8590";
            };
          };
        }];

        # Essential keybindings only
        keybindings = let mod = "Mod4"; in {
          "${mod}+Return" = "exec alacritty";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec rofi -show drun";
          
          # Focus
          "${mod}+Left" = "focus left";
          "${mod}+Right" = "focus right";
          "${mod}+Up" = "focus up";
          "${mod}+Down" = "focus down";
          
          # Workspaces
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          
          # Move to workspace
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
          
          # Layout
          "${mod}+f" = "fullscreen toggle";
          "${mod}+Shift+space" = "floating toggle";
          
          # System
          "${mod}+Shift+r" = "restart";
        };
      };
    };

    # Simple i3status configuration
    home.file.".config/i3status/config".text = ''
      general {
        colors = true
        interval = 5
      }

      order += "wireless _first_"
      order += "ethernet _first_"
      order += "battery all"
      order += "disk /"
      order += "load"
      order += "memory"
      order += "tztime local"

      wireless _first_ {
        format_up = "W: (%quality at %essid)"
        format_down = "W: down"
      }

      ethernet _first_ {
        format_up = "E: %ip"
        format_down = "E: down"
      }

      battery all {
        format = "%status %percentage"
      }

      disk "/" {
        format = "%avail"
      }

      load {
        format = "%1min"
      }

      memory {
        format = "%used | %available"
        threshold_degraded = "1G"
        format_degraded = "MEMORY < %available"
      }

      tztime local {
        format = "%Y-%m-%d %H:%M:%S"
      }
    '';
  };
}
