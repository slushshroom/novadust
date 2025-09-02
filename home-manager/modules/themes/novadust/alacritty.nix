## alacritty.nix - Terminal theming module## alacritty.nix - Terminal theming module
{ config, pkgs, lib, ... }:

let
  colors = config.novadust.colors;
in
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

        colors = {
          primary = {
            background = colors.bg.primary;
            foreground = colors.text.primary;
            dim_foreground = colors.text.muted;
            bright_foreground = colors.text.primary;
          };
          
          cursor = {
            text = colors.bg.primary;
            cursor = colors.blue.primary;
          };
          
          vi_mode_cursor = {
            text = colors.bg.primary;
            cursor = colors.warm.orange;
          };
          
          search = {
            matches = {
              foreground = colors.bg.primary;
              background = colors.warm.yellow;
            };
          focused_match = {
            foreground = "0d1421";  # bg.primary
            background = "ffa726";  # warm.orange
          };
          };
          
          line_indicator = {
            foreground = "None";
            background = "None";
          };
          
          selection = {
            text = "CellForeground";
            background = "264f78";  # ui.selected
          };
          
          normal = {
            black = "0d1421";   # bg.primary
            red = "f85149";     # ui.error
            green = "66bb6a";   # cool.green
            yellow = "ffa726";  # warm.orange
            blue = "4a9eff";    # blue.primary
            magenta = "ab47bc"; # cool.purple
            cyan = "4dd0e1";    # cool.cyan
            white = "e6edf3";   # text.primary
          };
          
          bright = {
            black = "7d8590";   # text.muted
            red = "ff8a80";
            green = "a5d6a7";
            yellow = "ffcc80";
            blue = "6bb6ff";    # blue.light
            magenta = "ce93d8";
            cyan = "80deea";
            white = "e6edf3";   # text.primary
          };
          
          dim = {
            black = "1a2332";   # bg.secondary
            red = "c62828";
            green = "2e7d32";
            yellow = "f57c00";
            blue = "2968a3";    # blue.dark
            magenta = "7b1fa2";
            cyan = "00838f";
            white = "b6c2cf";   # text.secondary
          };
        };
        
        bell = {
          animation = "EaseOutExpo";
          duration = 0;
          color = "d29922";  # ui.warning
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
}
