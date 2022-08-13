# When you use a temporary virtualenv via mktmpenv, you have to actually run deactivate to clean up the temporary environment
# always deactivate environments before exiting the shell
[ "$VIRTUAL_ENV" ] && deactivate
