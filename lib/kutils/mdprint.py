from datetime import time, datetime


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
    print('{} \n'.format(note))

