# Directory structure for modular Novadust theme
# ~/.config/home-manager/modules/themes/novadust/

## colors.nix - Color palette definition
{ ... }:

{
  novadust.colors = {
    # Dark blue backgrounds
    bg = {
      primary = "#0d1421";
      secondary = "#1a2332";
      tertiary = "#243244";
      elevated = "#2d3748";
    };
    
    # Text colors
    text = {
      primary = "#e6edf3";
      secondary = "#b6c2cf";
      muted = "#7d8590";
      disabled = "#484f58";
    };
    
    # Blue accent palette
    blue = {
      primary = "#4a9eff";
      dark = "#2968a3";
      light = "#6bb6ff";
      subtle = "#1f2937";
    };
    
    # Warm accents
    warm = {
      orange = "#ffa726";
      red = "#ff7043";
      yellow = "#ffeb3b";
    };
    
    # Cool accents
    cool = {
      green = "#66bb6a";
      purple = "#ab47bc";
      cyan = "#4dd0e1";
    };
    
    # UI elements
    ui = {
      border = "#30363d";
      hover = "#21262d";
      selected = "#264f78";
      focus = "#58a6ff";
      error = "#f85149";
      warning = "#d29922";
      success = "#3fb950";
    };
  };
}
