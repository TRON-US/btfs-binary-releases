# BTFS binary releases
This project provides all the binaries supported by btfs. See the attached operating system for detailed support.



## Supported OS

| OS      | ARCH  | Download                                                     |
| ------- | ----- | ------------------------------------------------------------ |
| darwin  | amd64 | [darwin-amd64](https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-darwin-amd64.tar) |
| darwin  | 386   | [darwin-386](https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-darwin-386.tar) |
| linux   | amd64 | [linux-amd64](https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-linux-amd64.tar) |
| linux   | 386   | [linux-386](https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-linux-386.tar) |
| windows | amd64 | [windows-amd64](https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-windows-amd64.zip) |
| windows | 386   | [window-386](https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-windows-386.zip) |



## Mac or Linux setup

1. Get  `install.sh` from GitHub.
```shell
wget https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/install.sh
```

2. Running script by your operating system and arch.

```shell
# bash install.sh -o (your operating system) -a (your arch)
bash install.sh -o darwin -a amd64
```

3. Add btfs path to environment.

```shell
export PATH=${PATH}:${HOME}/btfs/bin
```

4. Init btfs.

```shell
btfs init
```

5. Open the daemon.

```shell
btfs daemon
```



Now btfs on mac or linux is installed.



## Windows setup

1. Download the compressed file of your operating system's corresponding version via the link above.
2. Make sure you have permission to delete files in btfs project directory.
3. Initialize btfs path.
   1. Create a new btfs folder under the D drive.
   2. Go to the btfs folder.
   3. Copy your computer version of the btfs binary and config file to the btfs folder.
   4. Unzip the btfs binary and rename btfs.exe.
   5. Rename the btfs config to config.yaml
   6. Add the btfs folder to the environment variable.
4. Init btfs.

```shell
btfs.exe init
```

5. Open the daemon.

```
btfs.exe daemon
```
