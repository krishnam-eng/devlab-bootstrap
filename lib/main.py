import subprocess
import git
import time
from git import GitCommandError
from datetime import date, datetime
from pathlib import Path


def backup_safari_bookmarks(source_file='~/Library/Safari/Bookmarks.plist',
                            destination_folder='~/hrt/vault/bookmarks/safari/'):
    completed_process = subprocess.run("cp %s %s" % (source_file, destination_folder), shell=True)
    print("\t > {}".format(completed_process.args))
    print("\t >  {}".format(completed_process.stdout))


def sync_homelab(repo_path='~/hrt/boot/'):
    try:
        repo = git.Repo(repo_path)

        if is_any_changes(repo):
            print_git_status(repo)

            origin = repo.remote(name='origin')
            origin.pull()

            # do not add "." to avoid untracked file commits
            source_dirs = ["lib", "custom", "shell", "tools", "os"]
            for sd in source_dirs:
                stage_and_commit(repo, sd)

            origin.push()

            print_git_status(repo)
        else:
            print("[No New Changes Found] You are not quite dead yet! Keep changes coming... !")
    except GitCommandError:
        print('Error while pushing the change-set')
        print_git_status(repo)
        raise


def update_packages():
    state_key = 'brew'
    if is_stale(state_key):
        print_h2('Brew: Upgrade packages...')
        subprocess.run("brew update && brew outdated && brew upgrade && brew cleanup", shell=True)

        print_h2('Brew: Log Installed Packages...')
        subprocess.run("brew leaves | xargs -n1 brew desc > ~/hrt/boot/os/macosx/installed-packages.brew",
                                 shell=True)

        with open('{}/hrt/boot/os/macosx/installed-packages.brew'.format(Path.home()), 'w+') as f:
            for line in f.readlines():
                print(line)


def is_any_changes(repo):
    status = repo.git.status('--short')
    return status != ''


def stage_and_commit(repo, source_dir):
    repo.git.add([source_dir])
    if out_of_sync(repo, source_dir):
        commit_obj = repo.index.commit('[Auto committed] {} updates'.format(source_dir))
        print_commit_obj(commit_obj, source_dir)


def out_of_sync(repo, path):
    changed = [item.a_path for item in repo.index.diff(None)]
    staged = [item.a_path for item in repo.index.diff('Head')]
    return any(s.startswith(path) for s in changed) or any(s.startswith(path) for s in staged)


def is_stale(state_key):
    with open('{}/hrt/state/sync/{}.state'.format(Path.home(), state_key), 'w+') as f:
        state_value = f.readlines()

    if state_value is None or len(state_value) == 0:
        return True
    else:
        today = date.today()
        last_synced_date = datetime.strptime(state_value[0], '%Y%m%d').date()
        if last_synced_date != today:
            set_state_today(state_key)
            return True
        else:
            return False


def set_state_today(state_key):
    today = date.today().strftime('%Y%m%d')
    with open('{}/hrt/state/sync/{}.state'.format(Path.home(), state_key), 'w+') as f:
        f.writelines(today)


def print_git_status(repo):
    status = repo.git.status('--short')
    if status != '':
        print_around("git status:", status)


def print_commit_obj(commit_obj, name='git'):
    print('{} commit: ["{}", "{}"]'.format(name, commit_obj.hexsha, commit_obj.summary))


def print_h1(heading):
    print('\n')
    print(heading)
    print('=' * 60)


def print_h2(heading):
    print('\n')
    print(heading)
    print('-' * 40)


def print_around(subject, body):
    print(subject)
    print('- - ' * 10)
    print(body)
    print('- - ' * 10)


def print_footnote(note):
    print_h1("And finally…")
    print(f"Completed Execution in {time.perf_counter() - counter} seconds")
    print('{} \n'.format(note))


if __name__ == '__main__':
    counter = time.perf_counter()

    print_h1("Vault: Backup Safari Bookmarks...")
    backup_safari_bookmarks()

    print_h1("HomeBrew: Update Taps (third-party repositories) and Bottles (binary packages)..."
             "[remote -> local]")
    update_packages()

    print_h1("GitHub: Sync Dev Workspace - HomeLab, Tools Settings [local -> remote]...")
    sync_homelab()

    print_footnote("My brain hurts! Let's automate more !")

    print('But, Now !... [at least weekly once]')
    print('Export DBeaver Preferences        => [File -> Export]')
    print('Export IDE IDEA Preferences       => [File -> Manage IDE Settings -> Export]')
    print('Export IDE VSCode Preferences     => [Code -> Preferences -> Settings Sync is On]')
