# Docker Configuration

This directory contains Docker CLI configuration for macOS development environments.

## Automated Setup (via Provisioning)

This configuration is **automatically symlinked** during the provisioning process:

```bash
./provision-devlab.sh
```

The provisioning script will:
1. Backup any existing `~/.docker/config.json` (if not already a symlink)
2. Create a symlink: `~/.docker/config.json` → `conf/docker/config.json`
3. Verify Docker buildx is available

## Manual Setup

If you need to set this up manually:

```bash
# Backup existing config (if any)
[[ -f ~/.docker/config.json ]] && mv ~/.docker/config.json ~/.docker/config.json.backup

# Create symlink
ln -sfn ~/sbrn/sys/hrt/conf/docker/config.json ~/.docker/config.json

# Verify
ls -la ~/.docker/config.json
docker buildx version
```

## Purpose

The `config.json` file is used to configure Docker Desktop on macOS with:

1. **Credential Storage**: Uses macOS Keychain for secure credential management
2. **Plugin Discovery**: Enables Docker CLI to find plugins installed via Homebrew

## Why This Configuration?

### Credential Store (`credsStore`)
- **Purpose**: Securely stores Docker registry credentials in macOS Keychain
- **Benefit**: Avoids storing credentials in plain text
- **Usage**: When you run `docker login`, credentials are saved to macOS Keychain

### CLI Plugins Extra Directories (`cliPluginsExtraDirs`)
- **Purpose**: Tells Docker CLI where to find plugins installed via Homebrew
- **Benefit**: Enables `docker buildx` and other plugins installed at `/opt/homebrew/lib/docker/cli-plugins`
- **Why Needed**: Homebrew installs Docker plugins outside Docker's default plugin directory

## Buildx Context

This configuration is particularly important for **Docker buildx** usage:

```bash
# Without this config:
docker buildx version
# ERROR: buildx component is missing or broken

# With this config:
docker buildx version
# github.com/docker/buildx v0.x.x
```

### Buildx Use Cases in This Project

The workspace provisioner (`zf-workspace-provisioner`) uses Docker buildx for:

1. **Multi-stage builds**: Building TRACT wheels and provisioner images efficiently
2. **BuildKit features**: Advanced caching, parallel builds, and build optimizations
3. **Cross-platform builds**: Building for different architectures (if needed)

Example from `build.sh`:
```bash
DOCKER_BUILDKIT=1 docker build \
  --build-arg VERSION="${VERSION}" \
  --build-arg GIT_COMMIT="${COMMIT}" \
  -t zf-workspace-provisioner:${VERSION} \
  .
```

## Installation

1. **Copy to Docker config directory:**
   ```bash
   mkdir -p ~/.docker
   cp config.json ~/.docker/config.json
   ```

2. **Verify buildx is available:**
   ```bash
   docker buildx version
   ```

3. **If buildx is not found, install it:**
   ```bash
   brew install docker-buildx
   ```

4. **Restart Docker Desktop** (if needed) or your terminal session

## Verification

After installation, verify the configuration:

```bash
# Check config is loaded
cat ~/.docker/config.json

# Check buildx works
docker buildx version

# Check available builders
docker buildx ls
```

## Related Documentation

- [Docker BuildKit Documentation](https://docs.docker.com/build/buildkit/)
- [Docker Buildx Plugin](https://docs.docker.com/buildx/working-with-buildx/)
- [Homebrew Docker Installation](https://formulae.brew.sh/formula/docker)

## Troubleshooting

### Buildx not found after config update

1. **Verify plugin exists:**
   ```bash
   ls -la /opt/homebrew/lib/docker/cli-plugins/
   ```

2. **Restart terminal** or reload shell config:
   ```bash
   exec $SHELL
   ```

3. **Restart Docker Desktop** (macOS menu bar → Docker icon → Restart)

### Permission issues

If you get permission errors, check file ownership:
```bash
ls -la ~/.docker/config.json
# Should be owned by your user
```

Fix if needed:
```bash
chmod 600 ~/.docker/config.json
```

## Security Note

The `config.json` file contains configuration but **not actual credentials**. Credentials are stored separately in macOS Keychain via the `osxkeychain` credential helper.
