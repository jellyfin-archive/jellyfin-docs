---
uid: Fail2ban-Jellyfin
title: Fail2ban
---

## Fail2ban

Fail2Ban is an intrusion prevention software framework that protects computer servers from brute-force attacks.
Fail2Ban operates by monitoring log files (e.g. /var/log/auth.log, /var/log/apache/access.log, etc.) for selected entries and running scripts based on them.

Jellyfin produces log that can be monitored by Fail2ban to prevent brute-force attacks on remote instance of jellyfin.

### Requirements 

* Jellyfin remotely accessible
* Fail2ban installed and running
* Knowing where the log for Jellyfin are stored : by default /var/log/jellyfin/ 

### Step One create a jail 

You need to create a jail for Fail2ban.
If you are on Ubuntu and use nano as editor, type :

```
sudo nano /etc/fail2ban/jail.d/jellyfin.local
```

And add this to the file :

```
[jellyfin]

backend = auto
enabled = true
port = 80,443
protocol = tcp
filter = jellyfin
maxretry = 3
bantime = 86400
findtime = 43200
logpath = /var/log/jellyfin/jellyfin*.log
```

save and exit nano.

### Step Two Create a Filter

The filter explain to Fail2ban where to look in the log file. This is the tricky part

```
sudo nano /etc/fail2ban/filter.d/jellyfin.conf
```

And add this to the knew file (thanks to @sebres from F2B) :

```
[Definition]
failregex = ^(?:\[\]\s+)?\[INF\] Authentication request for "[^"]*" has been denied \(IP: "<HOST>"\)\.$
```

save and exit, then reload fail2ban :

```
sudo systemctl restart fail2ban
```

You're done.

### Step Three Test

You can test this new jail :

```
fail2ban-regex /var/log/jellyfin/*.log /etc/fail2ban/filter.d/jellyfin.conf
```

And see the output.


