## hyprland.nix
{ config, pkgs, lib, ... }:

{
  options.novadust.hyprland.enable = lib.mkEnableOption "Novadust Hyprland theme";

  config = lib.mkIf config.novadust.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      
      settings = {
        # Monitor configuration
        monitor = [ ",preferred,auto,auto" ];

        # Environment
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
        ];

        # Input
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
        };

        # General appearance
        general = {
          gaps_in = 8;
          gaps_out = 12;
          border_size = 2;
          "col.active_border" = "rgba(4a9effff)";
          "col.inactive_border" = "rgba(30363daa)";
          layout = "dwindle";
        };

        # Decoration
        decoration = {
          rounding = 12;
          blur = {
            enabled = true;
            size = 8;
            passes = 2;
          };
          drop_shadow = true;
          shadow_range = 30;
          "col.shadow" = "rgba(0d142180)";
        };

        # Animations
        animations = {
          enabled = true;
          bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
          animation = [
            "windows, 1, 7, myBezier"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Key bindings
        "$mainMod" = "SUPER";
        bind = [
          # Basic controls
          "$mainMod, RETURN, exec, alacritty"
          "$mainMod, Q, killactive"
          "$mainMod, M, exit"
          "$mainMod, V, togglefloating"
          "$mainMod, D, exec, wofi --show drun"
          "$mainMod, F, fullscreen"

          # Focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Workspaces 1-10
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move to workspace
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
        ];

        # Mouse bindings
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Autostart
        exec-once = [
          "waybar"
          "mako"
        ];
      };
    };

    # Simple Waybar configuration
    programs.waybar = {
      enable = true;
      settings = [{
        layer = "top";
        position = "top";
        height = 40;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "battery" "network" ];
        
        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
        };
        
        "hyprland/workspaces" = {
          disable-scroll = true;
        };
        
        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            default = [ "" "" "" ];
          };
        };
        
        battery = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        
        network = {
          format-wifi = "{essid} ";
          format-disconnected = "Disconnected ⚠";
        };
      }];
      
      # Simplified styling
      style = ''
        * {
          font-family: Inter;
          font-size: 13px;
        }
        window {
          background: #0d1421;
          color: #e6edf3;
        }
        #workspaces button {
          padding: 0 5px;
          color: #b6c2cf;
        }
        #workspaces button.active {
          background: #4a9eff;
          color: #e6edf3;
        }
        #clock, #pulseaudio, #battery, #network {
          padding: 0 10px;
        }
      '';
    };

    # Simple Mako configuration
    services.mako = {
      enable = true;
      backgroundColor = "#1a2332";
      borderColor = "#30363d";
      textColor = "#e6edf3";
      borderRadius = 12;
      borderSize = 2;
      defaultTimeout = 5000;
      font = "Inter 11";
    };
  };
}
