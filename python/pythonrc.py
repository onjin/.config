#!/usr/bin/env python
import atexit
import os


try:
    import readline
    import rlcompleter
except ImportError:
    readline = None
    rlcompleter = None

if readline:
    readline.parse_and_bind('tab: complete')

    history = os.path.expanduser('~/.pythonhist')

    def save_history(history=history):
        import readline
        readline.write_history_file(history)

    if os.path.exists(history):
        try:
            readline.read_history_file(history)
        except IOError:
            pass

    atexit.register(save_history)
    del save_history, history

del os, atexit, readline, rlcompleter
