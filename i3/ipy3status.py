from i3pystatus import Status
from i3pystatus.mail import thunderbird
from i3pystatus.format_bar import FormatBar

status = Status()

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("keyboard_locks",
                format="{caps}",
                caps_on="⇪",
                caps_off="",
                color="FF4E60")

status.register("clock",
                format="%a %-d %b %X",)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
                format="♪{volume}",)


status.register("backlight",
                format="☀{percentage}%",
                interval=10)


# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load")

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
                format="{temp:.0f}°C",)

status.register("mail",
                backends=[thunderbird.Thunderbird(account="gmail"),
                          thunderbird.Thunderbird(account="gmx")],
                email_client='i3-msg -q [class=\"^Thunderbird$\"] focus',
                format_plural = "{account}: {current_unread}/{unread}",
                format="✉{unread}",
                hide_if_null=False)

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via D-Bus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
# If you don't have a desktop notification demon yet, take a look at dunst:
#   http://www.knopwob.org/dunst/
status.register("battery",
                battery_ident="BAT1",
                format="{status}[/{consumption:.1f}W] {percentage:.0f}%[ {remaining:%E%hh:%Mm}]",
                alert=True,
                alert_timeout=5,
                alert_percentage=5,
                status={
                    "DIS": "↓",
                    "CHR": "↑",
                    "FULL": "=",
                    "DPL": "0"
                },)
status.register("battery",
                battery_ident="BAT0",
                format="{status}[/{consumption:.1f}W] {percentage:.0f}%[ {remaining:%E%hh:%Mm}]",
                alert=True,
                alert_timeout=5,
                alert_percentage=5,
                status={
                    "DIS": "↓",
                    "CHR": "↑",
                    "FULL": "=",
                    "DPL": "0"
                },)

# # This would look like this:
# # Discharging 6h:51m
# status.register("battery",
#                 format="{status} {remaining:%E%hh:%Mm}",
#                 alert=True,
#                 alert_percentage=5,
#                 status={
#                     "DIS":  "Discharging",
#                     "CHR":  "Charging",
#                     "FULL": "Bat full",
#                 },)

# # Displays whether a DHCP client is running
# status.register("runwatch",
#                 name="DHCP",
#                 path="/var/run/dhclient*.pid",)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
                interface="eth0",
                format_up="{v4cidr}",
                format_down="",)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
                interface="wlan0",
                format_up="{essid} {quality:.0f}%",)
status.register("net_speed",
                format = "↓{speed_down:.1f}{down_units} ↑{speed_up:.1f}{up_units}",
                units="B")

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
                path="/",
                format="√{free:.0f}G",
                critical_limit=5)
status.register("disk",
                path="/home",
                format="⌂{free:.0f}G ",
                critical_limit=20,
                hints={"separator_block_width": 0})
# bar = FormatBar()
# bar.register("disk",
#              path="/",
#              format="{percentage_free}")
# #                format="������{used:.0f}/{total:.0f}G",)
# bar.register("disk",
#              path="/home",
#              format="{percentage_free}")
# #                format="⌂{used:.0f}/{total:.0f}G",)
# status.register(bar)

# Shows mpd status
# Format:
# Cloud connected▶Reroute to Remain
status.register("mpd",
                host="192.168.0.9",
                format="{title} {status} {album}",
                status={
                    "pause": "▷",
                    "play": "▶",
                    "stop": "◾",
                },
                on_leftclick="switch_playpause",
                on_rightclick=["mpd_command", "stop"],
                on_middleclick="firefox http://192.168.0.9:6680/iris",
                on_upscroll=["mpd_command", "seekcur -10"],
                on_downscroll=["mpd_command", "seekcur +10"])


status.run()
