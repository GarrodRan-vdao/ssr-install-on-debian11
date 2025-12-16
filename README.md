[中文说明](README_CN.md)
# SSR systemd Installer (Debian 11)

This repository provides a **systemd-based installation script** for an
archived ShadowsocksR (SSR) codebase on **Debian 11**.

⚠️ This project is intended for **existing SSR users** who already
understand their configuration and protocol choices.

------------------------------------------------------------------------

## Features

-   Designed for **Debian 11**
-   Uses **systemd** for process management
-   Does **NOT** use `rc.local`
-   Does **NOT** use `logrun.sh`
-   Does **NOT** modify or generate configuration files
-   Keeps protocol / obfs behavior unchanged

This installer focuses on **environment setup only**.

------------------------------------------------------------------------

## What This Script Does

The `install.sh` script will:

1.  Install required system dependencies (`python2`, `git`, etc.)
2.  Clone an archived SSR codebase
3.  Install a `systemd` service unit
4.  Enable the service at boot

It will **NOT**:

-   Start the SSR service automatically
-   Generate or edit any JSON configuration
-   Change encryption, protocol, or obfuscation settings

------------------------------------------------------------------------

## Supported System

-   Debian GNU/Linux 11 (Bullseye)
-   systemd-based systems only

Other distributions are **not supported**.

------------------------------------------------------------------------

## Installation

Run as `root`:

``` bash
git clone https://github.com/GarrodRan-vdao/ssr-install-on-debian11
cd ssr-install-on-debian11
bash install.sh
```

After installation, the SSR service will be **enabled but not started**.

------------------------------------------------------------------------

## Configuration

This installer does not create configuration files.

If `user-config.json` does not exist in the SSR directory, you may
generate a template manually:

``` bash
cd /opt/shadowsocksr
bash initcfg.sh
```

Then, edit it:

```
vim user-config.json
```

⚠️ **Always review and edit the generated configuration carefully**
before starting the service.

Check more about configuration files editing if you need: https://doubibackup.com/m_u379fq.html

------------------------------------------------------------------------

## Service Management

Start SSR:

``` bash
systemctl start ssr
```

Check status:

``` bash
systemctl status ssr
```

View logs:

``` bash
journalctl -u ssr -n 50 --no-pager
```

------------------------------------------------------------------------

## Related Project

-   My own archived SSR codebase: https://github.com/GarrodRan-vdao/ssr-archive
-   👆which is a cold copy of: https://github.com/ToyoDAdoubiBackup/shadowsocksr

------------------------------------------------------------------------

## Disclaimer

This repository exists for **archival and compatibility purposes**.

ShadowsocksR is no longer actively maintained upstream. Use at your own
risk and responsibility.

This installer was created to keep legacy SSR deployments usable on modern Debian systems.