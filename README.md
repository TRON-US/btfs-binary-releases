# BTFS binary releases
This project provides all the binaries supported by btfs. See the attached operating system for detailed support.



## Supported OS

| OS      | ARCH  | Download                                                     |
| ------- | ----- | ------------------------------------------------------------ |
| darwin  | amd64 | [darwin-amd64](https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/darwin/amd64/btfs-darwin-amd64.tar) |
| darwin  | 386   | [darwin-386](https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/darwin/386/btfs-darwin-386.tar) |
| linux   | amd64 | [linux-amd64](https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/linux/amd64/btfs-linux-amd64.tar) |
| linux   | 386   | [linux-386](https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/linux/386/btfs-linux-386.tar) |
| windows | amd64 | [windows-amd64](https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/windows/amd64/btfs-windows-amd64.tar) |
| windows | 386   | [window-386](https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/windows/386/btfs-windows-386.tar) |



## Mac or Linux setup

1. Download the tarball of your operating system's corresponding version via the link above.

2. Make sure you have permission to delete files in your HOME directory.
3. Initialize btfs path.

```shell
wget https://raw.githubusercontent.com/TRON-US/btfs-binary-releases/master/install.sh
bash install.sh -o (your operating system) -a (your arch)
e.g.
bash install.sh -o darwin -a amd64
```

4. Add `${HOME}/btfs` to your path environment variable.

```shell
export PATH=${PATH}:${HOME}/btfs
```

5. Init btfs.

```shell
btfs init
```

6. Open the daemon.

```shell
btfs daemon
```



Now btfs on mac or linux is already installed.



## Windows setup

1. Download the tarball of your operating system's corresponding version via the link above.
2. Make sure you have permission to delete files in btfs project directory.
3. Initialize btfs path.
   1. Create a new btfs folder under the D drive.
   2. Go to the btfs folder.
   3. Copy your computer version of the btfs binary and config to the btfs folder.
   4. Rename the btfs binary to btfs.exe.
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
