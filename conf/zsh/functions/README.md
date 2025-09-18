# ZSH Functions Modular System

## Overview
This system implements Separation of Concerns (SoC) and follows the Open-Closed Principle (OCP) for managing zsh functions in a modular, extensible way.

## Directory Structure
```
conf/zsh/
├── rc.d/
│   ├── functions.zsh          # Main integration point
│   └── dev.aliases.zsh        # Pure aliases only
└── functions/
    ├── _loader.zsh            # Function loader system
    ├── git.zsh               # Git-related functions
    └── [module].zsh          # Additional function modules
```

## Architecture Principles

### Separation of Concerns (SoC)
- **Aliases**: Pure command shortcuts in `dev.aliases.zsh`
- **Functions**: Complex logic in dedicated module files under `functions/`
- **Loader**: Function management system in `_loader.zsh`
- **Integration**: Main loading point in `functions.zsh`

### Open-Closed Principle (OCP)
- **Open for extension**: Add new function modules by creating new `.zsh` files
- **Closed for modification**: Core loader system doesn't need changes for new modules
- **Automatic discovery**: New modules are automatically loaded without configuration

## Usage

### Loading Functions
Functions are automatically loaded when you source `functions.zsh`:
```bash
source /Users/balamurugank/sbrn/sys/hrt/conf/zsh/rc.d/functions.zsh
```

### Available Functions

#### Git Functions (`git.zsh`)
- `gitws [directory]` - Update all git repositories in a workspace

#### Function Management
- `list_zsh_functions` - List all available function modules
- `reload_zsh_functions` - Reload all function modules (useful for development)
- `create_function_module <name>` - Create a new function module template

### Creating New Function Modules

1. **Using the helper function:**
   ```bash
   create_function_module docker
   ```

2. **Manual creation:**
   ```bash
   # Create new module file
   touch conf/zsh/functions/docker.zsh
   
   # Add your functions following the template pattern
   # Functions will be automatically loaded on next shell start or reload
   ```

3. **Example module structure:**
   ```bash
   #!/usr/bin/env zsh
   # Docker functions  
   # Description: Functions for managing Docker containers and images

   docker_cleanup() {
       # Function implementation
   }
   
   docker_logs_tail() {
       # Function implementation  
   }
   ```

### Development Workflow

1. **Create new module:**
   ```bash
   create_function_module mymodule
   ```

2. **Edit the module:**
   ```bash
   # Edit conf/zsh/functions/mymodule.zsh
   # Add your functions
   ```

3. **Test immediately:**
   ```bash
   reload_zsh_functions
   ```

4. **Functions are now available:**
   ```bash
   mymodule_function_name
   ```

## Integration with .zshrc

Add this line to your `.zshrc` or main zsh configuration:
```bash
# Load function modules
source /Users/balamurugank/sbrn/sys/hrt/conf/zsh/rc.d/functions.zsh
```

## Benefits

1. **Modularity**: Each domain has its own file (git, docker, aws, etc.)
2. **Maintainability**: Easy to find and modify specific functionality
3. **Extensibility**: Add new modules without touching existing code
4. **Reusability**: Modules can be shared independently
5. **Testing**: Individual modules can be tested in isolation
6. **Documentation**: Each module is self-documenting with clear purpose

## Environment Variables

- `ZSH_FUNCTIONS_DIR`: Override default functions directory path
- `ZSH_FUNCTIONS_VERBOSE`: Enable verbose loading output

## Example: Adding AWS Functions

```bash
# Create the module
create_function_module aws

# Edit conf/zsh/functions/aws.zsh
aws_profile_switch() {
    export AWS_PROFILE="$1"
    echo "Switched to AWS profile: $1"
}

aws_s3_sync_bucket() {
    aws s3 sync "$1" "$2" --delete
}

# Functions are automatically available after:
reload_zsh_functions
```

This modular system ensures clean separation, easy maintenance, and infinite extensibility for your zsh functions.