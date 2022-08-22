from datetime import date, datetime
from pathlib import Path


def is_stale(state_key):
    try:
        with open('{}/hrt/state/sync/{}.state'.format(Path.home(), state_key), 'r') as f:
            state_value = f.readlines()
    except FileNotFoundError:
        f = open('{}/hrt/state/sync/{}.state'.format(Path.home(), state_key), 'w+')
        state_value = None
        f.close()

    if state_value is None or len(state_value) == 0:
        return True
    else:
        today = date.today()
        last_synced_date = datetime.strptime(state_value[0], '%Y%m%d').date()
        if last_synced_date != today:
            return True
        else:
            return False


def mark_updated(state_key):
    today = date.today().strftime('%Y%m%d')
    with open('{}/hrt/state/sync/{}.state'.format(Path.home(), state_key), 'w+') as f:
        f.writelines(today)
