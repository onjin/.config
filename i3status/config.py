#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from itertools import takewhile
import subprocess
from i3pystatus import Status, IntervalModule


status = Status()

status.register('clock', format="%a %-d %b %X KW%V")
status.register('load')
status.register('temp', format='{temp:.0f}°C')
status.register(
    "battery",
    format="{status}/{consumption:.2f}W {percentage:.2f}% [{percentage_design:.2f}%] {remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)

status.register(
    "network", interface="eth0", format_up="{v4}",
)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register(
    "network", interface="wlan0", format_up="{essid} {quality:03.0f}% {v4}",
)

status.register(
    'makewatch',
)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register(
    "disk", path="/", format="{used}/{total}G [{avail}G]",
)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register(
    "pulseaudio", format="♪{volume}",
)

# status.register(
#    'spotify', format='{status} {artist}/{title}/{album}'
# )


class VagrantWatch(IntervalModule):
    settings = (
        'format',
    )
    colors = {
        'started': '#FF0000',
        'halted': '#00FF00',
        'unknown': '#FFFFFF',
    }
    name = 'vagrant'
    format = '{name}: {running}/{all}'

    def run(self):
        status = 'halted'

        def finish(x):
            if x.startswith((' ', 'There are no')):
                return False
            return True

        result = str(subprocess.check_output(
            ['vagrant', 'global-status']
        )).split('\\n')
        rows = [
            r for r in
            takewhile(finish, result[2:])
        ]
        all_vagrants = len(rows)
        running_vagrants = len([r for r in rows if 'running' in r])
        if running_vagrants:
            status = 'started'

        color = self.colors.get(status, '#FFFFFF')
        self.data = {
            'name': self.name,
            'status': status,
            'all': all_vagrants,
            'running': running_vagrants,
        }
        self.output = {
            'full_text': self.format.format(**self.data),
            'color': color
        }

status.register(VagrantWatch)


status.run()
