{ config, pkgs, lib, ... }:

{
  options.novadust.rofi.enable = lib.mkEnableOption "Novadust Rofi theme";

  config = lib.mkIf config.novadust.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      
      font = "Inter Medium 12";
      
      extraConfig = {
        modi = "drun,run,window,ssh";
        show-icons = true;
        icon-theme = "Papirus-Dark";
        display-drun = "󰀻 Apps";
        display-run = " Run";
        display-window = " Windows";
        display-ssh = " SSH";
        drun-display-format = "{name}";
        window-format = "{w} · {c} · {t}";
        matching = "fuzzy";
        sort = true;
        threads = 0;
        scroll-method = 0;
        disable-history = false;
        cycle = true;
        sidebar-mode = false;
        hover-select = true;
        eh = 1;
        auto-select = false;
        parse-hosts = true;
        parse-known-hosts = true;
        case-sensitive = false;
        click-to-exit = true;
      };
    };

    # Simplified Rofi theme with direct colors
    home.file.".config/rofi/novadust.rasi".text = ''
      * {
        bg: #0d1421;
        bg-alt: #1a2332;
        bg-selected: #264f78;
        
        fg: #e6edf3;
        fg-alt: #b6c2cf;
        
        border: #30363d;
        selected: #4a9eff;
        active: #66bb6a;
        urgent: #f85149;
        
        background-color: transparent;
        text-color: @fg;
        font: "Inter Medium 12";
      }

      window {
        transparency: "real";
        background-color: @bg;
        border: 2px;
        border-color: @border;
        border-radius: 12px;
        width: 600px;
        location: center;
        anchor: center;
      }

      prompt {
        enabled: true;
        padding: 8px;
        background-color: @bg-alt;
        text-color: @fg;
        border-radius: 8px;
        margin: 0px 8px 0px 0px;
      }

      textbox-prompt-colon {
        expand: false;
        str: " ";
        background-color: @bg-alt;
        text-color: @fg;
        padding: 8px 12px;
        border-radius: 8px;
      }

      entry {
        background-color: @bg-alt;
        text-color: @fg;
        placeholder-color: @fg-alt;
        expand: true;
        horizontal-align: 0;
        placeholder: "Search applications...";
        blink: true;
        border-radius: 8px;
        padding: 8px 12px;
      }

      inputbar {
        children: [ textbox-prompt-colon, entry ];
        background-color: @bg;
        expand: false;
        border-radius: 8px;
        margin: 0px 0px 20px 0px;
        padding: 0px;
        position: center;
      }

      listview {
        background-color: @bg;
        columns: 1;
        lines: 8;
        spacing: 4px;
        cycle: true;
        dynamic: true;
        layout: vertical;
        border-radius: 8px;
      }

      mainbox {
        background-color: @bg;
        children: [ inputbar, listview ];
        spacing: 0px;
        padding: 20px;
      }

      element {
        background-color: @bg;
        text-color: @fg;
        orientation: horizontal;
        border-radius: 8px;
        padding: 10px;
        margin: 2px;
      }

      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 32px;
        border: 0px;
        margin: 0px 12px 0px 0px;
      }

      element-text {
        background-color: transparent;
        text-color: inherit;
        expand: true;
        horizontal-align: 0;
        vertical-align: 0.5;
      }

      element normal.urgent,
      element alternate.urgent {
        background-color: @urgent;
        text-color: @bg;
        border-radius: 8px;
      }

      element normal.active,
      element alternate.active {
        background-color: @active;
        text-color: @bg;
        border-radius: 8px;
      }

      element selected {
        background-color: @selected;
        text-color: @bg;
        border-radius: 8px;
      }
    '';
  };
}
