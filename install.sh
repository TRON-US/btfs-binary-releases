#!/usr/bin/env bash

OS="DEFAULT"
ARCH="DEFAULT"

while [[ -n "$1" ]]; do
    case "$1" in
        -o)
            OS="$2"
            if [[ "${OS}" != "darwin" && "${OS}" != "linux" ]]; then
                echo "The operating system you entered isn't supported, please correct and retry. Supported: darwin, linux. darwin means macOS."
                exit 1
            fi
            shift 2
            ;;
        -a)
            ARCH="$2"
            if [[ "${ARCH}" != "amd64" && "${ARCH}" != "386" ]]; then
                echo "The arch you entered isn't supported, please correct and retry. Supported: amd64, 386"
                exit 1
            fi
            shift 2
            ;;
        *)
            echo "Wrong arguments, correct usage: bash install.sh -o OS -a ARCH"
            echo "Supported OS: darwin, linux; supported arch: amd64, 386. darwin means macOS."
            exit 1
            ;;
    esac
done

if [[ "${ARCH}" = "DEFAULT" ]]; then
    echo "Please enter operating system. Supported: darwin, linux. darwins means macOS."
    exit 1
fi

if [[ "${OS}" = "DEFAULT" ]]; then
    echo "Please enter arch. Supported: amd64, 386"
    exit 1
fi

n=0
while true; do

    m=0
    while true; do
        curl -fL -o config_${OS}_${ARCH}_downloaded.yaml https://github.com/TRON-US/go-btfs/releases/latest/download/config_${OS}_${ARCH}.yaml && curl -fL -O https://github.com/TRON-US/go-btfs/releases/latest/download/btfs-${OS}-${ARCH}.tar && break
        let "m++"
        if [[ "${m}" -ge 3 ]]; then echo "Download of installation file failed, confirm your internet connection to GitHub is working and rerun this script."; exit 1; fi
        sleep 5
    done

    MD5_FROM_CONFIG_FILE=$(grep md5 config_${OS}_${ARCH}_downloaded.yaml | awk '{print $2}')

    tar -xf btfs-${OS}-${ARCH}.tar

    case ${OS} in
        darwin)
            if ! command -v md5 > /dev/null; then echo "Please install md5 command first, then rerun this script."; exit 1; fi
            MD5=$(md5 -r btfs-${OS}-${ARCH} | awk '{print $1}')
            ;;
        linux)
            if ! command -v md5sum > /dev/null; then echo "Please install md5sum command first, then rerun this script."; exit 1; fi
            MD5=$(md5sum btfs-${OS}-${ARCH} | awk '{print $1}')
            ;;
    esac

    if [[ "${MD5}" = "${MD5_FROM_CONFIG_FILE}" ]]; then break; fi
    let "n++"
    if [[ "${n}" -ge 3 ]]; then echo "Installation file is corrupted, confirm your internet connection to GitHub is working and rerun this script."; exit 1; fi
    sleep 5
done

rm btfs-${OS}-${ARCH}.tar config_${OS}_${ARCH}_downloaded.yaml

BTFSPATH=${HOME}/btfs

if [[ -d "${BTFSPATH}" ]]; then
    echo "~/btfs already exists, deleting ~/btfs first..."
    rm -rf ${BTFSPATH}
    echo "Deleting ~/btfs succeeded!"
fi

mkdir -p ${BTFSPATH}/bin
mv btfs-${OS}-${ARCH} ${BTFSPATH}/bin/btfs
mv config_${OS}_${ARCH}.yaml ${BTFSPATH}/bin/config.yaml

echo "Installation of BTFS succeeded!"
exit 0
