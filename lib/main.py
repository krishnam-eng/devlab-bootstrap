import getopt
import subprocess
import sys
import git
import time
from pathlib import Path
from kutils import mdprint, hrtstate, gitw;

# global variables
is_force_run = False
counter = time.perf_counter()


def backup_safari_bookmarks(source_file='~/Library/Safari/Bookmarks.plist',
                            destination_folder='~/hrt/vault/bookmarks/safari/'):
    mdprint.print_h1("Vault: Backup Safari Bookmarks...")
    state_key = 'safari'
    if hrtstate.is_stale(state_key) or is_force_run:
        completed_process = subprocess.run("cp %s %s" % (source_file, destination_folder), shell=True)
        hrtstate.mark_updated(state_key)
        print("\t > {}".format(completed_process.args))
        if completed_process.stdout is not None:
            print("\t >  {}".format(completed_process.stdout))
    else:
        print("Already ran today ! Skipping !")


def sync_homelab(repo_path='~/hrt/boot/'):
    mdprint.print_h1("GitHub: Sync Dev Workspace - HomeLab, Tools Settings [local -> remote]...")

    try:
        repo = git.Repo(repo_path)

        if gitw.is_stale(repo, None):
            gitw.print_git_status(repo)

            origin = repo.remote(name='origin')
            origin.pull()

            # do not add "." to avoid untracked file commits
            source_dirs = ["lib", "custom", "shell", "tools", "os"]
            for sd in source_dirs:
                gitw.stage_and_commit(repo, sd)

            origin.push()

            gitw.print_git_status(repo)
        else:
            print("Already up-to-date !")
    except git.GitCommandError:
        print('Error while pushing the change-set')
        gitw.print_git_status(repo)
        raise


def update_packages():
    mdprint.print_h1("HomeBrew: Update Taps (third-party repositories) and Bottles (binary packages)..."
                     "[remote -> local]")
    state_key = 'brew'
    if hrtstate.is_stale(state_key) or is_force_run:
        mdprint.print_h2('Brew: Upgrade packages...')
        subprocess.run("brew update && brew outdated && brew upgrade && brew cleanup", shell=True)

        mdprint.print_h2('Brew: Log Installed Packages...')
        # with w+, create or reset the file - empty it.
        f = open('{}/hrt/boot/os/macosx/installed-packages.brew'.format(Path.home()), 'w+')
        f.close()
        subprocess.run("brew leaves | xargs -n1 brew desc >> ~/hrt/boot/os/macosx/installed-packages.brew",
                       shell=True)
        hrtstate.mark_updated(state_key)
        with open('{}/hrt/boot/os/macosx/installed-packages.brew'.format(Path.home()), 'r') as f:
            for line in f.readlines():
                print(line)
    else:
        print("Already ran today ! Skipping !")


def process_cmd_options():
    global is_force_run
    try:
        opts, args = getopt.getopt(sys.argv[1:], "f", ["force"])
        for opt, arg in opts:
            if opt in ("-f", "--force"):
                is_force_run = True
    except getopt.GetoptError:
        sys.exit(2)


def after_all():
    mdprint.print_footnote("My brain hurts! Let's automate more !")

    print('But, Now !... [at least weekly once]')
    print('Export DBeaver Preferences        => [File -> Export]')
    print('Export IDE IDEA Preferences       => [File -> Manage IDE Settings -> Export]')
    print('Export IDE VSCode Preferences     => [Code -> Preferences -> Settings Sync is On]')


if __name__ == '__main__':
    process_cmd_options()
    backup_safari_bookmarks()
    update_packages()
    sync_homelab()
    after_all()
