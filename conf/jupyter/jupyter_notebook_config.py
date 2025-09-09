# Jupyter XDG-compliant configuration
# Configuration for Jupyter Notebook and JupyterLab

c = get_config()

# Server settings
c.NotebookApp.ip = '127.0.0.1'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = True
c.NotebookApp.notebook_dir = '~'

# Security settings
c.NotebookApp.token = ''  # Remove token requirement for local development
c.NotebookApp.password = ''
c.NotebookApp.disable_check_xsrf = False

# File handling
c.NotebookApp.allow_remote_access = False
c.NotebookApp.allow_root = False

# Kernel management
c.MultiKernelManager.default_kernel_name = 'python3'

# Extension settings
c.NotebookApp.nbserver_extensions = {
    'jupyter_ai': True,
    'jupyter_lsp': True,
}

# Content management
c.ContentsManager.allow_hidden = False
c.ContentsManager.delete_to_trash = True

# Terminal settings
c.NotebookApp.terminals_enabled = True
c.TerminalManager.shell_command = ['/bin/zsh']

# Logging
c.Application.log_level = 'INFO'
c.NotebookApp.log_format = '%(color)s[%(levelname)1.1s %(asctime)s.%(msecs).03d %(name)s]%(end_color)s %(message)s'

# Performance settings
c.NotebookApp.max_buffer_size = 1073741824  # 1GB
c.NotebookApp.max_body_size = 1073741824    # 1GB

# Shutdown settings
c.NotebookApp.shutdown_no_activity_timeout = 0  # Disable auto-shutdown
c.MappingKernelManager.cull_idle_timeout = 0    # Disable kernel culling
