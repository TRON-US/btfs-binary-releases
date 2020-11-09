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
            if [[ "${ARCH}" != "amd64" && "${ARCH}" != "386" && "${ARCH}" != "arm64" && "${ARCH}" != "arm" ]]; then
                echo "The arch you entered isn't supported, please correct and retry. Supported: amd64, 386, arm64, arm"
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
    echo "Please enter operating system. Supported: darwin, linux. darwin means macOS."
    exit 1
fi
if [[ "${OS}" = "DEFAULT" ]]; then
    echo "Please enter arch. Supported: amd64, 386, arm64, arm"
    exit 1
fi

mkdir -p /tmp/btfs.tmp && cd /tmp/btfs.tmp

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

m=0
while true; do
    curl -fL -O https://github.com/TRON-US/btfs-distributions/raw/master/fs-repo-migrations/versions && break
    let "m++"
    if [[ "${m}" -ge 3 ]]; then echo "Download of fs-repo-migrations version file failed, confirm your internet connection to GitHub is working and rerun this script."; exit 1; fi
    sleep 5
done
VERSION=$(cat versions | sort -V | tail -n 1)

FILE1="fs-repo-migrations_${VERSION}_${OS}-${ARCH}.tar.gz"
FILE2="fs-repo-migrations_${VERSION}_${OS}-${ARCH}.tar.gz.sha512"
URL1="https://github.com/TRON-US/btfs-distributions/raw/master/fs-repo-migrations/${VERSION}/${FILE1}"
URL2="https://github.com/TRON-US/btfs-distributions/raw/master/fs-repo-migrations/${VERSION}/${FILE2}"
n=0
while true; do
    m=0
    while true; do
        curl -fL -O "${URL1}" && curl -fL -O "${URL2}" && break
        let "m++"
        if [[ "${m}" -ge 3 ]]; then echo "Download of fs-repo-migrations files failed, confirm your internet connection to GitHub is working and rerun this script."; exit 1; fi
        sleep 5
    done

    if ! command -v shasum > /dev/null; then echo "Please install shasum command first, then rerun this script."; exit 1; fi
    SHA512=$(shasum -a 512 "${FILE1}" | awk '{print $1}')
    SHA512_FROM_FILE=$(grep "${FILE1}" "${FILE2}" |awk '{print $1}')
    if [[ "${SHA512}" = "${SHA512_FROM_FILE}" ]]; then break; fi

    let "n++"
    if [[ "${n}" -ge 3 ]]; then echo "${FILE1} is corrupted, confirm your internet connection to GitHub is working and rerun this script."; exit 1; fi
    sleep 5
done
tar -xzf "${FILE1}"

BTFSPATH=${HOME}/btfs
if [[ -d "${BTFSPATH}" ]]; then
    echo "~/btfs already exists, deleting ~/btfs first..."
    rm -rf "${BTFSPATH}"
    echo "Deleting ~/btfs succeeded!"
fi

mkdir -p ${BTFSPATH}/bin
mv btfs-${OS}-${ARCH} ${BTFSPATH}/bin/btfs
mv config_${OS}_${ARCH}.yaml ${BTFSPATH}/bin/config.yaml
mv  fs-repo-migrations/fs-repo-migrations ${BTFSPATH}/bin/

rm -rf /tmp/btfs.tmp

echo "Installation of BTFS succeeded!"
exit 0
