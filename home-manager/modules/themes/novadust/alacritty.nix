{ config, pkgs, lib, ... }:

{
  options.novadust.alacritty.enable = lib.mkEnableOption "Novadust Alacritty theme";

  config = lib.mkIf config.novadust.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        
        window = {
          opacity = 0.95;
          padding = {
            x = 12;
            y = 12;
          };
          decorations = "buttonless";
          startup_mode = "Windowed";
          dynamic_title = true;
        };

        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        font = {
          normal = {
            family = "JetBrains Mono";
            style = "Regular";
          };
          bold = {
            family = "JetBrains Mono";
            style = "Bold";
          };
          italic = {
            family = "JetBrains Mono";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrains Mono";
            style = "Bold Italic";
          };
          size = 13.0;
        };

        # Fixed with direct color values
        colors = {
          primary = {
            background = "#0d1421";
            foreground = "#e6edf3";
            dim_foreground = "#7d8590";
            bright_foreground = "#e6edf3";
          };
          
          cursor = {
            text = "#0d1421";
            cursor = "#4a9eff";
          };
          
          vi_mode_cursor = {
            text = "#0d1421";
            cursor = "#ffa726";
          };
          
          search = {
            matches = {
              foreground = "#0d1421";
              background = "#ffeb3b";
            };
            focused_match = {
              foreground = "#0d1421";
              background = "#ffa726";
            };
          };
          
          line_indicator = {
            foreground = "None";
            background = "None";
          };
          
          selection = {
            text = "CellForeground";
            background = "#264f78";
          };
          
          normal = {
            black = "#0d1421";
            red = "#f85149";
            green = "#66bb6a";
            yellow = "#ffa726";
            blue = "#4a9eff";
            magenta = "#ab47bc";
            cyan = "#4dd0e1";
            white = "#e6edf3";
          };
          
          bright = {
            black = "#7d8590";
            red = "#ff8a80";
            green = "#a5d6a7";
            yellow = "#ffcc80";
            blue = "#6bb6ff";
            magenta = "#ce93d8";
            cyan = "#80deea";
            white = "#e6edf3";
          };
          
          dim = {
            black = "#1a2332";
            red = "#c62828";
            green = "#2e7d32";
            yellow = "#f57c00";
            blue = "#2968a3";
            magenta = "#7b1fa2";
            cyan = "#00838f";
            white = "#b6c2cf";
          };
        };
        
        bell = {
          animation = "EaseOutExpo";
          duration = 0;
          color = "#d29922";
        };
        
        mouse = {
          hide_when_typing = true;
        };
        
        hints = {
          alphabet = "jfkdls;ahgurieowpq";
          enabled = [
            {
              regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001f\\u007f-\\u009f<>\"\\s{-}\\^⟨⟩`]+";
              command = "xdg-open";
              post_processing = true;
              mouse = {
                enabled = true;
                mods = "None";
              };
              binding = {
                key = "U";
                mods = "Control|Shift";
              };
            }
          ];
        };
      };
    };
  };
}
