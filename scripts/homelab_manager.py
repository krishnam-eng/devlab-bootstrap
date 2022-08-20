import getopt
import subprocess
import sys
import git
import time
from pathlib import Path
from kutils import mdprint, hrtstate, gitw
import speedtest

# global variables
is_force_run = False
counter = time.perf_counter()


def backup_safari_bookmarks(source_file='~/Library/Safari/Bookmarks.plist',
                            destination_folder='~/hrt/vault/bookmarks/safari/'):
    mdprint.print_h1("Vault: Backup Safari Bookmarks...")
    state_key = 'safari'
    if hrtstate.is_stale(state_key) or is_force_run:
        completed_process = subprocess.run("cp %s %s" % (
            source_file, destination_folder), shell=True)
        hrtstate.mark_updated(state_key)
        print("\t > {}".format(completed_process.args))
        if completed_process.stdout is not None:
            print("\t >  {}".format(completed_process.stdout))
    else:
        print("Already ran today ! Skipping !")


# ! source_dirs: do not add "." to avoid untracked file commits


def sync_gitrepo(repo_path, source_dirs):
    mdprint.print_h1(
        "GitHub: Sync Dev Workspace - HomeLab, Tools Settings [local -> remote]...")

    try:
        repo = git.Repo(repo_path)

        if gitw.is_stale(repo, None):
            gitw.print_git_status(repo)

            origin = repo.remote(name='origin')
            origin.pull()

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


def update_gitrepos(repo_list_filename='{}/hrt/vault/git/repos.path'.format(Path.home()), ):
    mdprint.print_h1(
        "BitBucket: Update Project Repos [remote -> local]...")

    state_key = 'project_repos'
    if hrtstate.is_stale(state_key):
        with open(repo_list_filename) as file:
            lines = file.readlines()
            repo_paths = [line.rstrip() for line in lines]
        for repo_path in repo_paths:
            print('-----------< {} >--------------'.format(repo_path))
            try:
                repo = git.Repo(repo_path)
                if gitw.is_stale(repo, None):
                    gitw.print_git_status(repo)
                    origin = repo.remote(name='origin')
                    origin.pull()
                else:
                    print("Already up-to-date !")
            except git.GitCommandError:
                print('Error while pulling from remote')
                gitw.print_git_status(repo)
                raise


def update_packages(out):
    banner = "HomeBrew: Update Taps (third-party repositories) and Bottles (binary packages)...[remote -> local]"
    mdprint.print_h1(banner)
    state_key = 'brew'
    if hrtstate.is_stale(state_key) or is_force_run:
        mdprint.print_h2('Brew: Upgrade packages...')
        subprocess.run(
            "brew update && brew outdated && brew upgrade && brew cleanup", shell=True)
        mdprint.print_h2('Brew: Log Installed Packages...')
        # with w+, create or reset the file - empty it.
        f = open(out, 'w+')
        f.close()
        subprocess.run("brew leaves | xargs -n1 brew desc >> {}".format(out), shell=True)
        hrtstate.mark_updated(state_key)
        with open(out, 'r') as f:
            for line in f.readlines():
                print(line)
    else:
        print("Already ran today ! Skipping !")


def speed_test():
    print("\nSpeed Test Results:")
    print("-------------------")
    speedtest_obj = speedtest.Speedtest()

    download_speed = speedtest_obj.download()
    print("Download: {} Mbits/s".format(bytes_to_mb(download_speed)))

    upload_speed = speedtest_obj.upload()
    print("Upload: {} Mbits/s".format(bytes_to_mb(upload_speed)));


def bytes_to_mb(value_in_bytes):
    kb = 1024
    mb = kb * 1024
    return int(value_in_bytes / mb)


def after_all():
    mdprint.print_footnote("My brain hurts! Let's automate more !")
    print(f"Completed Execution in {time.perf_counter() - counter} seconds \n")

    print('But, Now !... [at least weekly once]')
    print('Run Repo Manager')
    print('Export DBeaver Preferences        => [File -> Export]')
    print(
        'Export IDE IDEA Preferences       => [File -> Manage IDE Settings -> Export]')
    print(
        'Export IDE VSCode Preferences     => [Code -> Preferences -> Settings Sync is On]')
    print(
        'Upgrade IDE VSCode Preferences     => [Code -> Preferences -> Settings Sync is On]')


def process_cmd_options():
    global is_force_run
    try:
        opts, args = getopt.getopt(sys.argv[1:], "f", ["force", "rpath="])
        for opt, arg in opts:
            if opt in ("-f", "--force"):
                is_force_run = True
    except getopt.GetoptError:
        sys.exit(2)


if __name__ == '__main__':
    process_cmd_options()

    backup_safari_bookmarks()

    update_packages(out='{}/hrt/boot/desktop/macosx/installed-packages.brew'.format(Path.home()))

    sync_gitrepo(repo_path='~/hrt/boot/', source_dirs=["conf", "custom", "desktop", "helpers", "scripts", "settings"])
    sync_gitrepo(repo_path='~/hrt/vault/', source_dirs=["bookmarks", "dbeaver", "git", "intellij", "mvn", "pipeline", "postman", "scripts", "springboot", "sublime", "zsh"])

    update_gitrepos()

    after_all()

    speed_test()
