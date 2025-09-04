{ config, pkgs, lib, ... }:

{
  options.novadust.wofi.enable = lib.mkEnableOption "Novadust Wofi theme";

  config = lib.mkIf config.novadust.wofi.enable {
    programs.wofi = {
      enable = true;
      
      settings = {
        width = 600;
        height = 400;
        location = "center";
        show = "drun";
        prompt = "Search applications...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 32;
        gtk_dark = true;
        term = "alacritty";
        exec_search = true;
        hide_scroll = true;
        parse_search = false;
        print_command = true;
        layer = "overlay";
        sort_order = "default";
        matching = "contains";
      };
      
      # Fixed with direct color values
      style = ''
        window {
          margin: 0px;
          border: 2px solid #30363d;
          border-radius: 12px;
          background-color: #0d1421;
          font-family: Inter;
          font-size: 14px;
          font-weight: 500;
        }

        #input {
          padding: 12px;
          margin: 12px 12px 8px 12px;
          border-radius: 8px;
          border: none;
          background-color: #1a2332;
          color: #e6edf3;
          font-size: 14px;
          font-weight: 500;
        }

        #input:focus {
          border: 2px solid #4a9eff;
          outline: none;
        }

        #inner-box {
          margin: 5px;
          border: none;
          background-color: transparent;
        }

        #outer-box {
          margin: 5px;
          border: none;
          background-color: transparent;
        }

        #scroll {
          margin: 0px;
          border: none;
          background-color: transparent;
        }

        #text {
          margin: 5px;
          border: none;
          color: #e6edf3;
          font-weight: 500;
        }

        #text:selected {
          color: #e6edf3;
        }

        #entry {
          padding: 10px 12px;
          margin: 2px 8px;
          border-radius: 8px;
          border: none;
          background-color: transparent;
          transition: all 200ms ease-in-out;
        }

        #entry:hover {
          background-color: #21262d;
        }

        #entry:selected {
          background-color: #264f78;
          color: #e6edf3;
        }

        #entry:selected #text {
          color: #e6edf3;
          font-weight: 600;
        }

        #entry img {
          margin-right: 8px;
          border-radius: 4px;
        }

        scrollbar {
          background-color: transparent;
          width: 8px;
        }

        scrollbar slider {
          background-color: #30363d;
          border-radius: 4px;
          min-height: 20px;
        }

        scrollbar slider:hover {
          background-color: #7d8590;
        }
      '';
    };
  };
}
