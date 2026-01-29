## 📦 Local APT Repository for deb packages from GitHub or other sites

This repository provides a shell script and accompanying `systemd` unit files to automatically create and update a **local Debian APT repository** with `.deb` packages from GitHub Releases or from other sites by using custom scripts.


### ✅ Features

* Automatically detects your Debian version (e.g., `bookworm`, `trixie`)
* Downloads the latest `.deb` packages specified in `/etc/localrepo/packages.conf`
* Builds a local APT repo in `/usr/local/localrepo`
* Adds the corresponding `localrepo.list` file in `/etc/apt/sources.list.d`
* Runs weekly via a `systemd` timer
* Works seamlessly with `apt update` and `apt upgrade`
* Useful packages preconfigured in packages.conf: `mergerfs`, `sleepproxyclient`, `plexmediaserver`
* Script to get download URL of Plex Media Server directly from plex.tv


### 📁 Files

| File | Description 
| --- | --- |
| `update-localrepo` | main script to create/update the local repo |
| `update-localrepo.service` | systemd service to run the script |
| `update-localrepo.timer` | systemd timer to schedule weekly execution |
| `install.sh` | install script |
| `uninstall.sh` | uninstall script |
| `geturl-plex` | script to get Plex download URL directly from plex.tv |


### 🛠 Requirements

Ensure the following packages are installed:

```
sudo apt install curl jq dpkg-dev lsb-release
```


### 🚀 Installation

1. **Clone this repo**

   ```
   git clone https://github.com/lisanet/update-localrepo.git
   ```
   
2. **Run the install script**

 First ensure that the install.sh script is executable.

 ```
 cd update-localrepo
 chmod a+x install.sh
 ```

 then run it:

 ```
 sudo ./install.sh
 ```
 This copies the updater script to `/usr/local/bin`, installs the systemd files into `/etc/systemd/system` and enables the systemd timer. 


### 🧪 Usage

The updater script will run once a week, looking for updated packages and donwloads them if necessary. You can use `apt update`, `apt list --upgradable` and `apt upgrade` as usual.  

You can run `update-localrepo` manually too with these options:

```
Usage: sudo update-localrepo [-v] [-c] [-h]
  -v    Verbose output
  -c    Clean the repository before updating
  -h    Show this help message
```

To trigger an update at anytime. It's recommend to do this right after installation.

```
sudo update-localrepo
```

To clean the repository before updating

```
sudo update-localrepo -c
```

### 📂 Local Repository Location

After a successful run, the local repo is available at `/usr/local/localrepo`. The corresponding sources.list file is automatically added to `/etc/apt/sources.list.d/localrepo.list`. 


### 🧼 Uninstall

To fully uninstall the script, timer, service, and the local repo and sources.list, just run 
the uninstall.sh script in the cloned repo directory, after ensuring it's executable.

```
cd update-localrepo
chown a+x uninstall.sh
sudo ./uninstall.sh
```

Finally update your apt sources list:

```
sudo apt update
```

### 📬 License

BSD 2-clause – free to use, modify, and distribute.


### 🤝 Contributing

Contributions, bug reports, and feature requests are welcome. Please open an issue or submit a pull request if you have any improvements or suggestions.


### ⚠️ Disclaimer

update-localrepo is provided **"as is"** without any warranty. Use at your own risk. Always ensure that you have current backups of your data.

