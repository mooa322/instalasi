![alt text](https://github.com/kucrutjr12/vps-script/blob/main/kucrutjr.png?raw=true)

## INSTALL SCRIPT 
Masukkan perintah dibawah untuk menginstall Autoscript Premium
```
apt update && apt upgrade -y --fix-missing && update-grub && sleep 2 && apt install -y wget && apt install -y curl && apt install haproxy -y && apt install build-essential -y && apt-get install -y jq && apt-get install shc && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/mooa322/instalasi/main/setup.sh && chmod +x setup.sh && ./setup.sh
```

## jika gagal pakai yang ini
```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt upgrade -y --fix-missing && update-grub && sleep 2 && apt install -y wget && apt install -y curl && apt install haproxy -y && apt install build-essential -y && apt-get install -y jq && apt-get install shc && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/mooa322/instalasi/main/setup.sh && chmod +x setup.sh && ./setup.sh
```

### fix haproxy off
```
wget --no-check-certificate https://daneshswara.serv00.net/fixhap.sh && chmod +x fixhap.sh && ./fixhap.sh
```

---

## SSH expiry: disconnecting expired accounts

Expired SSH accounts used to stay online. Locking the account, changing its
password, or deleting it does **not** end a session that is already running —
sshd and dropbear check credentials once, at login time, and never again. The
only thing that drops a live session is killing the processes serving it.

Two scripts handle this (installed to `/usr/local/sbin` like the rest of the menu):

| script | what it does |
| --- | --- |
| `kickuser <user> [--lock] [--delete]` | Disconnects one account's live sessions now: the sshd privsep monitor, the session child, the login shell, port-forwarding helpers, and the matching dropbear process. Optionally locks and/or deletes the account. |
| `expkill [--quiet]` | Walks `/etc/shadow`, and for every expired account locks it, kicks it, then deletes it. SSH only — it does not touch xray. |

`expkill` runs from `/etc/cron.d/expkill` every minute, so an expired account is
dropped within a minute instead of waiting for the daily `xp` job. `xp`, `delexp`,
`lock` and `tendang` all route through `kickuser`.

Useful checks on the server:

```
grep expired /root/log-expired.txt     # what expkill removed, and when
kickuser <username>                    # disconnect someone right now
ps -eo pid,user,args | grep '^sshd:'    # who is actually still connected
```

## Editing the menu scripts

The menu ships as `menu/menu.zip`, built from the plain-text scripts in
`menu/src`. Edit those, then rebuild and commit both:

```
./menu/build.sh
```
