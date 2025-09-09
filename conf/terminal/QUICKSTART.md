# iTerm2 Profiles Quick Setup Guide

## Systematic iTerm Profile Management - Quick Reference

### 🚀 Initial Setup (New Machine)

```bash
# 1. Navigate to terminal config
cd ~/sbrn/sys/hrt/conf/terminal

# 2. Install all color schemes
./manage-iterm-profiles.sh install

# 3. Import profiles (follow prompts)
./manage-iterm-profiles.sh import
```

### 📋 Daily Commands

```bash
# List current setup
./manage-iterm-profiles.sh list

# Create backup before changes
./manage-iterm-profiles.sh backup

# Export current profiles
./manage-iterm-profiles.sh export

# Full sync (backup + export)
./manage-iterm-profiles.sh sync
```

### 🎨 Available Color Schemes

Your setup includes 9 professionally curated themes:
- **Catppuccin Mocha** - Modern, warm dark theme
- **GitHub Dark** - Clean, professional dark theme  
- **Nord North** - Arctic-inspired cool theme
- **Solarized Dark** - Classic, eye-friendly theme
- **Gotham Night** - Dark, high-contrast theme
- **Cobalt Atom** - Vibrant blue-based theme
- **Jelly Beans** - Colorful, playful theme
- **Noctis Night** - Dark theme optimized for night work
- **Purple Shades** - Purple-tinted elegant theme

### 📝 Profile Organization Strategy

**1. Create Purpose-Based Profiles:**
```
Development-Dark (Catppuccin Mocha)
Development-Light (Solarized Light)
SSH-Production (GitHub Dark + red accents)
Presentation (High contrast, large fonts)
Focus-Mode (Minimal, distraction-free)
```

**2. Standardize Settings:**
- Font: FiraCode Nerd Font 14pt
- Window: 80x24 initial size
- Scrollback: 10,000 lines
- Background transparency: 5-10%

**3. Set Hotkeys:**
- ⌘+1: Primary development profile
- ⌘+2: SSH/remote profile
- ⌘+3: Light theme for bright environments

### 🔧 Advanced Setup

**Create profile variations:**
```bash
# Copy your base development profile
# Then modify for specific use cases:

Dev-Large-Font     # For presentation/screen sharing
Dev-High-Contrast  # For bright lighting
Dev-SSH-Warn      # Red background tint for production
```

**Automation Integration:**
Add to your shell aliases:
```bash
# Add to ~/.zshrc
alias iterm-sync='~/sbrn/sys/hrt/conf/terminal/manage-iterm-profiles.sh sync'
alias iterm-backup='~/sbrn/sys/hrt/conf/terminal/manage-iterm-profiles.sh backup'
alias iterm-list='~/sbrn/sys/hrt/conf/terminal/manage-iterm-profiles.sh list'
```

### 🎯 Best Practices

1. **Before System Changes**: Always run `./manage-iterm-profiles.sh backup`
2. **After Customization**: Run `./manage-iterm-profiles.sh export`
3. **Weekly Maintenance**: Check `./manage-iterm-profiles.sh list`
4. **New Machine Setup**: Run install → import → verify

### 📁 File Structure You'll Have

```
conf/terminal/
├── manage-iterm-profiles.sh ✅ Management script
├── README.md               ✅ Full documentation  
├── QUICKSTART.md          ✅ This guide
├── colors/                ✅ 9 color schemes
│   ├── Catppuccin-Mocha.itermcolors
│   ├── GitHub-Dark.itermcolors
│   └── ... (7 more themes)
└── profiles/              ✅ Profile configurations
    ├── profiles.iterm2.json      # Main export
    ├── GitHub Dark.json          # Individual profiles
    └── profiles-backup-*.json    # Auto backups
```

### 🚨 Troubleshooting

**Script won't run:**
```bash
chmod +x manage-iterm-profiles.sh
```

**Colors not installing:**
- Ensure iTerm2 is running
- Try double-clicking `.itermcolors` files manually

**Profiles not importing:**
- Check JSON file format
- Use iTerm2 → Preferences → Profiles → Other Actions → Import

---

This systematic approach gives you:
- ✅ **Version controlled** color schemes and profiles
- ✅ **Automated backup** and restore processes  
- ✅ **Consistent environment** across machines
- ✅ **Easy maintenance** with simple commands
- ✅ **Professional themes** ready to use
