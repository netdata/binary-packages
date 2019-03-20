# binary-packages (**DEPRECATED**)

This repo hosts older binary packages for netdata. Please use the [releases page](https://github.com/netdata/netdata/releases) for newer binary packages.

## netdata `.run` files

Files ending in `.run` are Linux binary self-extracting shell scripts, generated with [`makeself`](https://github.com/megastep/makeself).

To use one, **download it and run it**.

To install the latest version use this:

```sh
bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh)
```

If your shell fails to handle the above one liner, do this:

```sh
curl -Ss https://my-netdata.io/kickstart-static64.sh >/tmp/kickstart-static64.sh
sh /tmp/kickstart-static64.sh
```

### installs in `/opt/netdata`

The package will install everything in `/opt/netdata` (remember to prepend `/opt/netdata` to command examples found in the netdata wiki).

The following changes will be made to the system:

1. user `netdata` will be added.
2. group `netdata` will be added.
3. logrotate configuration will be added at `/etc/logrotate.d/netdata`.
4. if the system is running `systemd`, the file `/etc/systemd/system/netdata.service` will be created.
5. if the system is not running systemd, then depending on the distribution and version the file `/etc/init.d/netdata` will be added. This works for older Ubuntu, Debian, CentOS and for OpenRC based Gentoo systems.

Other than the above, the system is not altered in any way.

### Statically linked

All programs included in the package are statically linked and do not depend on any
system library. The operating system is expected to provide very basic tools, like
`tar`, `gzip`, etc, so they can be used even if the system is just a `busybox`.
For example, these packages run on [CirrOS](https://launchpad.net/cirros).

You can use these binary files for installing netdata:

1. On ancient Linux installations, that you cannot update for a reason.
2. On Linux distributions that do not provide a package management system (CirrOS, CoreOS, etc).

### Key dependencies included

These packages include:

1. statically linked `BASH`, version 4+
2. statically linked `curl`, version 7.53.1+
3. statically linked `fping`, version 4.0+
4. statically linked `netdata`, version 1.6+, with statically linked `apps.plugin`.

### install and update

The packages can be used to update an existing installation made by another version of them.

If you want to use these packages on systems that you have installed netdata from source,
we suggest to **uninstall the previous version first**. If you don't uninstall it, these
package will fail to update your system properly (i.e. they will not overwrite the existing
`/etc/systemd/system/netdata.service`, `/etc/logrotate.d/netdata`, `/etc/init.d/netdata`).
