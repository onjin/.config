#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from i3pystatus import Status


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

#status.register(
#    'spotify', format='{status} {artist}/{title}/{album}'
#)

status.run()
