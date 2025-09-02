## hyprland.nix - Hyprland window manager theming module
{ config, pkgs, lib, ... }:

let
  colors = config.novadust.colors;
in
{
  options.novadust.hyprland.enable = lib.mkEnableOption "Novadust Hyprland theme";

  config = lib.mkIf config.novadust.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      
      settings = {
        # Monitor configuration (adjust as needed)
        monitor = [
          ",preferred,auto,auto"
        ];

        # Environment variables
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "GTK_THEME,Adwaita-dark"
        ];

        # Input configuration
        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;
          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
            disable_while_typing = true;
            tap-to-click = true;
          };
        };

        # General settings
        general = {
          # Gaps and borders
          gaps_in = 8;
          gaps_out = 12;
          border_size = 2;
          
          # Novadust colors
          "col.active_border" = "rgba(${builtins.substring 1 6 colors.blue.primary}ff) rgba(${builtins.substring 1 6 colors.blue.light}ff) 45deg";
          "col.inactive_border" = "rgba(${builtins.substring 1 6 colors.ui.border}aa)";

          layout = "dwindle";
          allow_tearing = false;
        };

        # Decoration settings
        decoration = {
          # Rounded corners
          rounding = 12;
          
          # Blur
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            brightness = 0.8;
            contrast = 1.4;
            ignore_opacity = true;
            noise = 0.0117;
            new_optimizations = true;
            xray = true;
          };

          # Shadow
          drop_shadow = true;
          shadow_range = 30;
          shadow_render_power = 3;
          "col.shadow" = "rgba(${builtins.substring 1 6 colors.bg.primary}80)";

          # Dim inactive windows
          dim_inactive = false;
          dim_strength = 0.1;
        };

        # Animation settings
        animations = {
          enabled = true;
          
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
            "easeOutQuart, 0.25, 1, 0.5, 1"
            "easeInOutCubic, 0.65, 0, 0.35, 1"
          ];

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Layout settings
        dwindle = {
          pseudotile = true;
          preserve_split = true;
          smart_split = false;
          smart_resizing = true;
        };

        master = {
          new_is_master = true;
          mfact = 0.55;
        };

        # Gestures
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };

        # Misc settings
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
          always_follow_on_dnd = true;
          layers_hog_keyboard_focus = true;
          animate_manual_resizes = false;
          enable_swallow = true;
          swallow_regex = "^(Alacritty|kitty|footclient)$";
        };

        # Window rules
        windowrule = [
          "float, ^(pavucontrol)$"
          "float, ^(blueman-manager)$"
          "float, ^(nm-connection-editor)$"
          "float, ^(file-roller)$"
          "float, ^(org.gnome.Calculator)$"
          "size 800 600, ^(pavucontrol)$"
          "center, ^(pavucontrol)$"
        ];

        windowrulev2 = [
          # Make Firefox PiP float and sticky
          "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "sticky, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "pin, class:^(firefox)$, title:^(Picture-in-Picture)$"
          
          # Opacity rules
          "opacity 0.95 0.95, class:^(Alacritty)$"
          "opacity 0.95 0.95, class:^(kitty)$"
          "opacity 0.90 0.90, class:^(Code)$"
          
          # Workspace assignments
          "workspace 2, class:^(firefox)$"
          "workspace 3, class:^(Code)$"
          "workspace 4, class:^(discord)$"
        ];

        # Key bindings
        "$mainMod" = "SUPER";

        bind = [
          # Program launches
          "$mainMod, RETURN, exec, alacritty"
          "$mainMod, Q, killactive"
          "$mainMod, M, exit"
          "$mainMod, E, exec, nautilus"
          "$mainMod, V, togglefloating"
          "$mainMod, D, exec, wofi --show drun"
          "$mainMod, P, pseudo"
          "$mainMod, J, togglesplit"
          "$mainMod, F, fullscreen"
          "$mainMod, L, exec, swaylock"

          # Move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Move windows
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"

          # Workspace switching
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

          # Scroll through workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # Special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Screenshots
          ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
          "$mainMod, Print, exec, grim - | wl-copy"
          "$mainMod SHIFT, Print, exec, grim -g \"$(slurp)\" ~/Pictures/$(date +'%Y%m%d_%H%M%S.png')"

          # Media keys
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ +5%"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ -5%"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"

          # Brightness control
          ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
          ", XF86MonBrightnessDown, exec, brightnessctl s -5%"
        ];

        # Mouse bindings
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Resize mode
        binde = [
          "$mainMod ALT, left, resizeactive, -20 0"
          "$mainMod ALT, right, resizeactive, 20 0"
          "$mainMod ALT, up, resizeactive, 0 -20"
          "$mainMod ALT, down, resizeactive, 0 20"
        ];

        # Startup applications
        exec-once = [
          "waybar"
          "mako"
          "swww init"
          "swww img ~/.config/wallpapers/novadust-bg.jpg"
          "swayidle -w timeout 300 'swaylock -f' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'"
          "nm-applet"
          "blueman-applet"
          "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        ];
      };
    };
  # Waybar configuration for Hyprland
    programs.waybar = {
      enable = true;
      
      settings = [{
        layer = "top";
        position = "top";
        height = 40;
        spacing = 8;
        
        modules-left = [ "hyprland/workspaces" "hyprland/mode" "wlr/taskbar" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ 
          "idle_inhibitor" 
          "pulseaudio" 
          "network" 
          "cpu" 
          "memory" 
          "temperature" 
          "backlight"
          "keyboard-state"
          "battery"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            urgent = "";
            focused = "";
            default = "";
          };
        };

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "hyprland/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "hyprland/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = [ "" "" ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 2;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
      }];

      style = ''
        * {
            border: none;
            border-radius: 0;
            font-family: Inter, Font Awesome 6 Free;
            font-weight: 500;
            font-size: 13px;
            min-height: 0;
        }

        window#waybar {
            background-color: ${colors.bg.primary};
            border-bottom: 2px solid ${colors.ui.border};
            color: ${colors.text.primary};
            transition-property: background-color;
            transition-duration: .5s;
        }

        button {
            box-shadow: inset 0 -3px transparent;
            border: none;
            border-radius: 0;
        }

        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px ${colors.blue.primary};
        }

        #workspaces button {
            padding: 0 5px;
            background-color: transparent;
            color: ${colors.text.secondary};
        }

        #workspaces button:hover {
            background: ${colors.ui.hover};
        }

        #workspaces button.focused {
            background-color: ${colors.ui.selected};
            color: ${colors.text.primary};
            box-shadow: inset 0 -3px ${colors.blue.primary};
        }

        #workspaces button.urgent {
            background-color: ${colors.ui.error};
            color: ${colors.text.primary};
        }

        #mode {
            background-color: ${colors.bg.secondary};
            border-bottom: 2px solid ${colors.text.primary};
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #wireplumber,
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #scratchpad,
        #mpd {
            padding: 0 10px;
            color: ${colors.text.primary};
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            background-color: ${colors.bg.secondary};
            color: ${colors.text.primary};
        }

        #battery {
            background-color: ${colors.bg.secondary};
            color: ${colors.text.primary};
        }

        #battery.charging, #battery.plugged {
            color: ${colors.cool.green};
            background-color: ${colors.bg.secondary};
        }

        @keyframes blink {
            to {
                background-color: ${colors.text.primary};
                color: ${colors.bg.primary};
            }
        }

        #battery.critical:not(.charging) {
            background-color: ${colors.ui.error};
            color: ${colors.text.primary};
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        label:focus {
            background-color: ${colors.bg.primary};
        }

        #cpu {
            background-color: ${colors.bg.secondary};
            color: ${colors.blue.primary};
        }

        #memory {
            background-color: ${colors.bg.secondary};
            color: ${colors.cool.green};
        }

        #disk {
            background-color: ${colors.bg.secondary};
        }

        #backlight {
            background-color: ${colors.bg.secondary};
            color: ${colors.warm.orange};
        }

        #network {
            background-color: ${colors.bg.secondary};
            color: ${colors.blue.light};
        }

        #network.disconnected {
            background-color: ${colors.ui.error};
            color: ${colors.text.primary};
        }

        #pulseaudio {
            background-color: ${colors.bg.secondary};
            color: ${colors.cool.purple};
        }

        #pulseaudio.muted {
            background-color: ${colors.text.muted};
            color: ${colors.bg.primary};
        }

        #temperature {
            background-color: ${colors.bg.secondary};
        }

        #temperature.critical {
            background-color: ${colors.ui.error};
        }

        #tray {
            background-color: ${colors.bg.secondary};
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: ${colors.ui.error};
        }

        #idle_inhibitor {
            background-color: ${colors.bg.secondary};
        }

        #idle_inhibitor.activated {
            

  # You can add any shared configuration here
  options.novadust.enable = lib.mkEnableOption "Novadust theme suite";

  config = lib.mkIf config.novadust.enable {
    # Enable all components by default when novadust is enabled
    novadust = {
      gtk.enable = lib.mkDefault true;
      alacritty.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
      # i3.enable is left false by default since not everyone uses i3
    };
  };
}