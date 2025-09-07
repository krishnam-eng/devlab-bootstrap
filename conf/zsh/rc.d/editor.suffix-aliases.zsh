################################################################################
# ZSH SUFFIX ALIASES (File Extension Command Mapping)
#
# WHAT IS IT:
#   Suffix aliases are a zsh feature that automatically executes a command when
#   you type a filename with a specific extension. They work by associating file
#   extensions with commands using the `alias -s` syntax.
#
# TERMINOLOGY:
#   - Suffix Alias: An alias triggered by file extension (~.ext)
#   - File Extension Mapping: Association between file types and commands
#   - Auto-execution: Automatic command invocation based on file suffix
#
# HOW TO USE:
#   Once defined, just type the filename and press Enter - zsh automatically
#   prepends the associated command:
#   
#   Code Files:
#     myfile.py                  # Automatically runs: code myfile.py
#     script.js                  # Automatically runs: code script.js
#     
#   Config Files:
#     .zshrc                     # Automatically runs: vim .zshrc
#     config.conf                # Automatically runs: vim config.conf
#     
#   Log Files:
#     error.log                  # Automatically runs: tail -f error.log
#     
#   Text Files:
#     readme.txt                 # Automatically runs: nano readme.txt
#
# HOW TO SET UP:
#   1. Define with alias -s:     alias -s ext=command
#   2. Multiple extensions:      alias -s {ext1,ext2,ext3}=command
#   3. Commands with options:    alias -s log="tail -f"
#   
# EXAMPLES:
#   alias -s py=vim                        # .py files open in vim
#   alias -s {js,ts}=code                  # .js and .ts files open in VS Code
#   alias -s log="tail -f"                 # .log files monitored with tail
#   alias -s {jpg,png}="open -a Preview"   # Images open in Preview
#
# BENEFITS:
#   - Instant file opening without typing commands
#   - Context-aware tool selection by file type
#   - Streamlined workflow for different file formats
#   - Automatic command completion
#   - Consistent behavior across file types
#
################################################################################

# === LOG & MONITORING FILES ===
alias -s log="tail -f"                    # Real-time log monitoring
alias -s {out,err}="tail -f"              # Output and error files
alias -s {access,error}="tail -f"         # Web server logs

# === PROGRAMMING LANGUAGES ===
# Web Development (Most Popular)
alias -s {js,ts,jsx,tsx}=code             # JavaScript/TypeScript React
alias -s {html,htm,css,scss,sass,less}=code # Web markup and styles
alias -s {vue,svelte}=code                # Modern JS frameworks
alias -s {json,jsonl,json5}=code          # JSON variants

# Backend Languages
alias -s {py,pyw,ipynb}=code              # Python (including Jupyter)
alias -s {java,kt,kts,scala}=code         # JVM languages
alias -s {go,mod,sum}=code                # Go language
alias -s {rs,toml}=code                   # Rust language
alias -s {php,phtml}=code                 # PHP
alias -s {rb,rake,gemspec}=code           # Ruby
alias -s {cs,fs,vb}=code                  # .NET languages

# Systems Programming
alias -s {c,cpp,cxx,cc,h,hpp,hxx}=code    # C/C++
alias -s {swift}=code                     # Swift (macOS/iOS)
alias -s {zig}=code                       # Zig language

# Shell Scripting
alias -s {sh,bash,zsh,fish}=code          # Shell scripts
alias -s {ps1,psm1}=code                  # PowerShell (cross-platform)

# === CONFIGURATION FILES ===
# System Configs
alias -s {zshrc,bashrc,vimrc,tmux.conf}=vim
alias -s {gitconfig,gitignore,gitattributes}=vim
alias -s {config,conf,cfg,ini}=vim
alias -s {env,environment}=vim

# Application Configs
alias -s {yaml,yml}=vim                   # YAML configs (K8s, Docker, CI/CD)
alias -s {xml,plist}=code                 # XML and macOS property lists
alias -s {dockerfile,dockerignore}="code" # Docker files
alias -s {makefile,mk}=vim                # Build files

# === DOCUMENTATION & TEXT ===
alias -s {md,markdown,mdx}=code           # Markdown (most popular docs format)
alias -s {txt,text}=nano                  # Plain text
alias -s {rst,asciidoc,adoc}=code         # Other documentation formats
alias -s {tex,latex}=code                 # LaTeX documents

# === DATA FORMATS ===
alias -s {csv,tsv}=code                   # Data files
alias -s {sql,ddl,dml}=code               # Database files
alias -s {graphql,gql}=code               # GraphQL schemas

# === ARCHIVES & COMPRESSED FILES ===
alias -s {zip,tar,gz,tgz,bz2,xz}="open"  # Auto-extract on macOS
alias -s {7z,rar}="open"                 # Archive formats

# === MEDIA FILES (macOS specific) ===
# Images
alias -s {jpg,jpeg,png,gif,webp,svg}="open -a Preview"
alias -s {bmp,tiff,tif,ico}="open -a Preview"
alias -s {raw,cr2,nef,arw}="open -a Preview"

# Videos
alias -s {mp4,mov,avi,mkv,webm,m4v}="open -a QuickTime\ Player"
alias -s {flv,wmv,mpg,mpeg}="open"

# Audio
alias -s {mp3,wav,aac,flac,m4a,ogg}="open -a Music"

# === OFFICE DOCUMENTS (macOS) ===
alias -s {pdf}="open -a Preview"          # PDF files
alias -s {doc,docx,rtf}="open"            # Word documents
alias -s {xls,xlsx,numbers}="open"        # Spreadsheets
alias -s {ppt,pptx,key}="open"            # Presentations

# === DEVELOPMENT TOOLS ===
# Package Managers
alias -s {package.json,package-lock.json}=code
alias -s {yarn.lock,pnpm-lock.yaml}=code
alias -s {requirements.txt,pyproject.toml}=code
alias -s {cargo.toml,cargo.lock}=code
alias -s {go.mod,go.sum}=code
alias -s {gemfile,gemfile.lock}=code
alias -s {composer.json,composer.lock}=code

# CI/CD Files
alias -s {gitlab-ci.yml,.github}=code
alias -s {jenkinsfile,pipeline}=code
alias -s {azure-pipelines.yml}=code

# Infrastructure as Code
alias -s {tf,tfvars,hcl}=code             # Terraform
alias -s {k8s.yaml,helm}=code             # Kubernetes
alias -s {ansible.yml,playbook.yml}=code  # Ansible

# === SPECIAL FORMATS ===
alias -s {proto,protobuf}=code            # Protocol Buffers
alias -s {thrift}=code                    # Apache Thrift
alias -s {avro,parquet}=code              # Big data formats
alias -s {schema}=code                    # Schema definitions

# === MOBILE DEVELOPMENT ===
alias -s {dart}=code                      # Flutter/Dart
alias -s {gradle,gradle.kts}=code         # Android builds
alias -s {xcconfig,xcworkspace,xcodeproj}="open" # iOS/macOS projects

# === WEB ASSEMBLY & PERFORMANCE ===
alias -s {wasm,wat}=code                  # WebAssembly
alias -s {benchmark,perf}=code            # Performance files
