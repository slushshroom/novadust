# Adding Novadust Theme to Existing Cinnamon NixOS

## What You'll Get

- ✅ **Keep Cinnamon** as your main desktop (unchanged)
- ✅ **Add Hyprland option** for when you want tiling WM
- ✅ **Improve Cinnamon's appearance** with Novadust GTK theming
- ✅ **Themed Alacritty terminal** that works in both environments
- ✅ **Multiple login options** - choose at login screen

## Step 1: Update Your System Configuration

Your current `/etc/nixos/configuration.nix` probably looks something like this:

```nix
# Your existing config with Cinnamon
services.xserver = {
  enable = true;
  displayManager.lightdm.enable = true;  # or gdm
  desktopManager.cinnamon.enable = true;
};
```

**Add Hyprland support** while keeping Cinnamon:

```bash
sudo nano /etc/nixos/configuration.nix
```

Add these sections (don't remove your existing Cinnamon config):

```nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Your other imports...
  ];

  # Keep your existing boot, networking, time zone, etc...

  # KEEP your existing Cinnamon config:
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;  # or whatever you have
    desktopManager.cinnamon.enable = true;
  };

  # ADD Hyprland support (this won't interfere with Cinnamon):
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # ADD Home Manager support (if not already present):
  programs.home-manager.enable = true;

  # ADD/UPDATE your user config (if not already correct):
  users.users.YOUR_USERNAME = {
    isNormalUser = true;
    description = "Your Name";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  # ADD audio config (PipeWire is better than PulseAudio):
  # You might already have PulseAudio - that's fine too
  sound.enable = true;
  hardware.pulseaudio.enable = false;  # Only if you want to switch from PulseAudio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ADD useful packages:
  environment.systemPackages = with pkgs; [
    # Your existing packages...
    
    # Add these for the theme:
    alacritty
    git
    wl-clipboard  # For Wayland clipboard
    
    # Optional: Keep your existing terminal too
    # gnome-terminal  # or whatever you use
  ];

  # Enable unfree packages (probably already there):
  nixpkgs.config.allowUnfree = true;

  # Keep your existing system.stateVersion...
}
```

Apply the changes:
```bash
sudo nixos-rebuild switch
```

## Step 2: Install Home Manager

```bash
# Add Home Manager channel (if not already added)
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update

# Install Home Manager (if not already installed)
nix-shell '<home-manager>' -A install
```

## Step 3: Create Home Manager Config with Novadust

```bash
mkdir -p ~/.config/home-manager
nano ~/.config/home-manager/home.nix
```

**Strategy 1: Full Novadust with Hyprland + Enhanced Cinnamon**

```nix
{ config, pkgs, ... }:

{
  imports = [
    (builtins.fetchTarball {
      url = "https://github.com/YOUR_GITHUB_USERNAME/novadust-nixos/archive/main.tar.gz";
      # Add SHA256 after first run
    })
  ];

  # Enable full Novadust theme
  novadust = {
    enable = true;
    hyprland.enable = true;  # Adds Hyprland as login option
    # This will also theme GTK apps in Cinnamon!
  };

  home = {
    username = "YOUR_USERNAME";
    homeDirectory = "/home/YOUR_USERNAME";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  # Additional config
  programs = {
    git = {
      enable = true;
      userName = "Your Name";
      userEmail = "your.email@example.com";
    };

    firefox.enable = true;
  };
}
```

**Strategy 2: Minimal Novadust (GTK + Terminal only)**

If you just want to improve Cinnamon's appearance without adding Hyprland:

```nix
{ config, pkgs, ... }:

{
  imports = [
    (builtins.fetchTarball {
      url = "https://github.com/YOUR_GITHUB_USERNAME/novadust-nixos/archive/main.tar.gz";
    })
  ];

  # Enable only GTK theming and terminal
  novadust = {
    gtk.enable = true;      # Makes Cinnamon look better
    alacritty.enable = true; # Beautiful terminal
    # Don't enable window managers
  };

  home = {
    username = "YOUR_USERNAME";
    homeDirectory = "/home/YOUR_USERNAME";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
```

## Step 4: Apply Home Manager Config

```bash
home-manager switch
```

(Add the SHA256 hash when prompted, then run again)

## Step 5: Test Your Options

**Log out** and you should now see multiple session options:

1. **Cinnamon** - Your original desktop (now with better GTK theming!)
2. **Hyprland** - New tiling window manager option (if you enabled it)

## What This Gives You

### In Cinnamon Session:
- ✅ **Better looking GTK apps** (dark theme, nice icons)
- ✅ **Beautiful Alacritty terminal** with Novadust colors
- ✅ **All your familiar Cinnamon features** still work
- ✅ **Same workflow** you're used to

### In Hyprland Session (if enabled):
- ✅ **Full Novadust experience** with tiling WM
- ✅ **Modern Wayland desktop**
- ✅ **Waybar, Wofi, all the bells and whistles**

## Screenshots/Testing

### Test GTK theming in Cinnamon:
1. Log into Cinnamon
2. Open `alacritty` - should have dark blue theme
3. Open any GTK app (Files, Settings) - should look darker/better
4. Check if you like it!

### Test Hyprland (if enabled):
1. Log out
2. Select "Hyprland" at login
3. Press `Super + Enter` for terminal
4. Press `Super + D` for app launcher
5. Press `Super + Q` to close windows

## Fine-tuning

### If you want to keep your old terminal in Cinnamon:
```nix
# In your home.nix, don't enable alacritty by default
novadust = {
  gtk.enable = true;
  # alacritty.enable = false;  # Keep using gnome-terminal in Cinnamon
  hyprland.enable = true;      # But still get it in Hyprland
};

# Then manually configure Alacritty just for Hyprland
programs.alacritty = {
  enable = true;
  # Custom config here if you want
};
```

### If you want Rofi instead of Wofi:
```nix
novadust = {
  enable = true;
  hyprland.enable = true;
  wofi.enable = false;  # Disable wofi
  rofi.enable = true;   # Enable rofi instead
};
```

## Benefits of This Approach

1. **Safe experimentation** - Cinnamon always works as fallback
2. **Gradual transition** - try Hyprland when you want, use Cinnamon when you need stability
3. **Improved existing desktop** - even Cinnamon looks better with Novadust GTK theme
4. **Best of both worlds** - traditional desktop + modern tiling WM

This is actually a really smart way to try out tiling window managers - you get to keep your comfortable environment while experimenting with something new!
