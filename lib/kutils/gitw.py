from kutils import mdprint


def stage_and_commit(repo, source_dir):
    repo.git.add([source_dir])
    if is_stale(repo, source_dir):
        commit_obj = repo.index.commit('[Auto committed] {} updates'.format(source_dir))
        print_commit_obj(commit_obj, source_dir)


def is_stale(repo, path):
    """
    Return True if any un-staged or un-committed changes in local repo for a given root directory path
    """
    if path is None:
        status = repo.git.status('--short')
        return status != ''
    else:
        changed = [item.a_path for item in repo.index.diff(None)]
        staged = [item.a_path for item in repo.index.diff('Head')]
        return any(s.startswith(path) for s in changed) or any(s.startswith(path) for s in staged)


def print_git_status(repo):
    status = repo.git.status('--short')
    if status != '':
        mdprint.print_around("git status:", status)


def print_commit_obj(commit_obj, name='git'):
    print('{} commit: ["{}", "{}"]'.format(name, commit_obj.hexsha, commit_obj.summary))
