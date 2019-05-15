# BTFS binary releases
This project provides all the binaries supported by btfs. See the attached operating system for detailed support.



## Mac or Linux setup

1. Download this repo.

```shell
cd ${HOME}
git clone https://github.com/TRON-US/btfs-binary-releases.git
```

2. Make sure you have permission to delete files in your HOME directory.
3. Initialize btfs path.

```shell
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

1. Download this repo.
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



## Supported OS

| OS      | ARCH  |
| ------- | ----- |
| darwin  | amd64 |
| darwin  | 386   |
| linux   | amd64 |
| linux   | 386   |
| windows | amd64 |
| windows | 386   |

