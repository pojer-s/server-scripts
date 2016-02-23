#!/usr/bin/env bash

install_debian_8() {
    aptitude update ; aptitude upgrade -y
    aptitude install apt-transport-https ca-certificates -y
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
    aptitude update
    aptitude install docker-engine -y
    service docker start
}

if ! [ -r /etc/lsb-release ] ; then
    echo "Cannot determine the OS"
    exit 1
fi

. /etc/lsb-release

case "${DISTRIB_ID}_${DISTRIB_RELEASE}" in
    Debian_8)
        install_debian_8
        ;;
    *)
        echo "Unsupported OS $DISTRIB_ID $DISTRIB_RELEASE"
        ;;
esac
