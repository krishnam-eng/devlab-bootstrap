################################################################################
# ZSH NAMED DIRECTORIES (Directory Hash Table)
#
# WHAT IS IT:
#   Named directories are a zsh feature that allows you to create short aliases
#   for frequently used directory paths. They work by adding entries to zsh's
#   internal "named directory hash table" using the `hash -d` command.
#
# TERMINOLOGY:
#   - Named Directory: A short alias (~name) that expands to a full directory path
#   - Directory Hash: The internal zsh table that stores name->path mappings
#   - Tilde Expansion: The process where ~name gets expanded to the actual path
#
# HOW TO USE:
#   Once defined, you can use named directories anywhere a path is expected:
#   
#   Navigation:
#     cd ~proj                   # Go to projects directory
#     cd ~proj/myapp             # Go to specific project
#     
#   File Operations:
#     ls ~rsrc/notes             # List notes directory
#     cp file.txt ~arch/         # Copy to archives
#     vim ~config/zsh/.zshrc     # Edit zsh config
#     
#   Tab Completion:
#     cd ~pro<TAB>               # Completes to ~proj
#     ls ~<TAB>                  # Shows all available named dirs
#
# HOW TO SET UP:
#   1. Define with hash -d:      hash -d shortname=/full/path/to/directory
#   2. Use tilde notation:       ~shortname expands to /full/path/to/directory
#   3. Can reference others:     hash -d subdir=~parent/child
#   
# EXAMPLES:
#   hash -d docs=$HOME/Documents           # ~docs -> /Users/you/Documents
#   hash -d proj=~docs/Projects            # ~proj -> /Users/you/Documents/Projects
#   hash -d myapp=~proj/MyApplication      # ~myapp -> /Users/you/Documents/Projects/MyApplication
#
# BENEFITS:
#   - Faster navigation with memorable shortcuts
#   - Consistent paths across different systems
#   - Tab completion support
#   - Works in all zsh contexts (cd, ls, vim, etc.)
#   - Hierarchical organization with references
#
################################################################################

# === Second Brain (SBRN) Core Directories ===
hash -d sbrn=$HOME/sbrn

# === PARA Method Directories ===
# Projects - Active work requiring completion by a specific deadline
hash -d proj=~sbrn/proj
hash -d oss=~sbrn/proj/oss            # Open source projects
hash -d learn=~sbrn/proj/learn        # Learning projects
hash -d lab=~sbrn/proj/lab            # Laboratory/experimental projects
hash -d workshop=~sbrn/proj/workshop # Workshop projects

# Areas - Ongoing responsibilities to maintain over time
hash -d area=~sbrn/area
hash -d work=~sbrn/area/work        # Work-related areas
hash -d personal=~sbrn/area/personal # Personal life areas
hash -d community=~sbrn/area/community # Community involvement
hash -d academic=~sbrn/area/academic # Academic pursuits

# Resources - Topics or themes of ongoing interest
hash -d rsrc=~sbrn/rsrc
hash -d notes=~sbrn/rsrc/notes      # Reference notes
hash -d templates=~sbrn/rsrc/templates # Template files
hash -d refs=~sbrn/rsrc/refs        # Reference materials

# Archives - Inactive items from the above three categories
hash -d arch=~sbrn/arch
hash -d archproj=~sbrn/arch/proj    # Archived projects
hash -d archarea=~sbrn/arch/area    # Archived areas

# === System Directories (XDG Compliant) ===
hash -d sys=~sbrn/sys
hash -d shrt=~sbrn/sys/hrt
hash -d sbin=~sbrn/sys/bin           # Custom executables
hash -d xdgconf=~sbrn/sys/config     # XDG_CONFIG_HOME
hash -d xdgdata=~sbrn/sys/local/share # XDG_DATA_HOME
hash -d xdgstate=~sbrn/sys/local/state # XDG_STATE_HOME
hash -d xdgcache=~sbrn/sys/cache       # XDG_CACHE_HOME

# === Cloud Storage Directories ===
hash -d drives=$HOME/Drives
hash -d icloud=~drives/iCloud       # iCloud Drive
hash -d gdrive=~drives/GoogleDrive  # Google Drive
hash -d onedrive=~drives/OneDrive   # Microsoft OneDrive
hash -d dropbox=~drives/Dropbox    # Dropbox

# === Development Environment Directories ===
hash -d android=~localshare/android # Android SDK
hash -d gradle=~localshare/gradle   # Gradle user home
