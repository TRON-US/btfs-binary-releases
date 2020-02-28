#!/bin/bash

OS="DEFAULT"
ARCH="DEFAULT"

while [[ -n "$1" ]] ;do
    case "$1" in
        -o)
            OS="$2"
            if [[ "${OS}" != "darwin" && "${OS}" != "linux" ]]; then
                echo "BTFS does not support the operating system you entered, please re-enter   support:linux,darwin"
                exit
            fi
            shift 2
            ;;
        -a)
            ARCH="$2"
            if [[ "${ARCH}" != "amd64" && "${ARCH}" != "386" ]]; then
                echo "BTFS does not support the arch you entered, please re-enter   support:amd64,386"
                exit
            fi
            shift 2
            ;;
        *)
            exit 1
            ;;
    esac
done

if [[ "${ARCH}" = "DEFAULT" ]]; then
    echo "Please input operating system."
    exit
fi

if [[ "${OS}" = "DEFAULT" ]]; then
    echo "Please input arch."
    exit
fi

cd ${HOME}

wget https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-${OS}-${ARCH}.tar
tar -xvf btfs-${OS}-${ARCH}.tar
rm btfs-${OS}-${ARCH}.tar

btfsPath=${HOME}/btfs

echo ${btfsPath}

if [[ -d "${btfsPath}" ]];then
    echo "~/btfs already exists, delete ~/btfs begin."
    rm -rf ${btfsPath}
    echo "Delete ~/btfs success!"
fi

mkdir ${HOME}/btfs
cd ${HOME}/btfs
mkdir bin
cd -
mv btfs-${OS}-${ARCH} ${HOME}/btfs/bin/btfs
mv config_${OS}_${ARCH}.yaml ${HOME}/btfs/bin/config.yaml

echo "Install btfs success!"
