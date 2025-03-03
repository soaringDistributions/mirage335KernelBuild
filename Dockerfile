
# https://moebuta.org/posts/using-github-actions-to-build-linux-kernels/?utm_source=chatgpt.com
# https://dev.to/emmanuelnk/using-sudo-without-password-prompt-as-non-root-docker-user-52bg
# https://stackoverflow.com/questions/35594987/how-to-force-docker-for-a-clean-build-of-an-image
# https://www.howtogeek.com/devops/how-to-make-docker-rebuild-an-image-without-its-cache/
# ATTRIBUTION-AI: ChatGPT  4o , o1  2025-01-18 .

#docker build --pull --no-cache --build-arg HOST_UID=$(id -u) --build-arg HOST_GID=$(id -g) -t debian_bookworm-docker-image:latest .
#
#docker run -it --name debian_bookworm-docker-container --rm -v $(cygpath -w $(_getAbsoluteLocation .)):/currentPWD:rw debian_bookworm-docker-image:latest bash -i
#
#docker run --name debian_bookworm-docker-container --rm -v "$PWD":/currentPWD:rw debian_bookworm-docker-image:latest bash -c './ubiquitous_bash.sh _echo test'
#
#docker run -it --name debian_bookworm-docker-container -v "$PWD":/currentPWD:rw debian_bookworm-docker-image:latest bash -c 'echo x | sudo -n tee /artifact.txt'
#docker cp debian_bookworm-docker-container:/artifact.txt ${{ github.workspace }}
#docker rm debian_bookworm-docker-container

# NOTICE: CAUTION: For MSWindows hosts, for a docker container, it may be necessary to   chown -R "$USER":"$USER"   /currentPWD . MSWindows host file ownership apparently may not change. WSL2 file ownership does change, and would need another 'chown' to correct . DANGER: This will cause all files in /currentPWD to have the same owner (ie. resetting root ownership of files created by root). In some situations (eg. Linux kernel build repository), that situation may or may not be acceptable.


FROM debian:bookworm



COPY <<"EOF" /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main
deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian-security/ bookworm-security main
deb-src http://deb.debian.org/debian-security/ bookworm-security main

deb http://deb.debian.org/debian bookworm-updates main
deb-src http://deb.debian.org/debian bookworm-updates main
EOF



RUN <<"EOF"
apt-get update
apt-get install build-essential wget git -y
apt-get build-dep linux -y

##xz btrfs-tools grub-mkstandalone mkfs.vfat mkswap mmd mcopy mksquashfs

#gpg pigz curl gdisk lz4 mawk jq gawk build-essential autoconf pkg-config bsdutils findutils patch tar gzip bzip2 sed lua-lpeg axel aria2 gh rsync pv expect libfuse2 udftools debootstrap cifs-utils dos2unix xxd debhelper p7zip nsis jp2a btrfs-progs btrfs-compsize zstd zlib1g coreutils util-linux kpartx openssl growisofs udev gdisk parted bc e2fsprogs xz-utils libreadline8 mkisofs genisoimage byobu xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils

##dnsutils bind9-dnsutils bison libelf-dev elfutils flex libncurses-dev libudev-dev dwarves pahole cmake sockstat liblinear4 liblua5.3-0 nmap nmap-common socat dwarves pahole libssl-dev cpio libgtk2.0-0 libwxgtk3.0-gtk3-0v5 wipe iputils-ping nilfs-tools python3 sg3-utils cryptsetup php
##qemu-system-x86
##qemu-user qemu-utils

apt-get install -y sudo gpg wget pigz dnsutils bind9-dnsutils curl gdisk parted lz4 mawk jq gawk build-essential bison libelf-dev elfutils flex libncurses-dev autoconf libudev-dev dwarves pahole cmake pkg-config bsdutils findutils patch tar gzip bzip2 flex sed sockstat liblinear4 liblua5.3-0 lua-lpeg nmap nmap-common socat axel aria2 gh rsync libssl-dev cpio pv expect libfuse2 cifs-utils dos2unix xxd debhelper p7zip iputils-ping btrfs-progs btrfs-compsize zstd zlib1g nilfs-tools coreutils python3 util-linux kpartx openssl udev cryptsetup bc e2fsprogs xz-utils libreadline8 byobu squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-common mtools dosfstools fdisk cloud-guest-utils trousers tpm-tools

apt-get install -y rustc cargo
EOF

# Allow members of the 'sudo' group to execute any command without a password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#RUN echo '%sudo   ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN chmod ugoa+r /etc/sudoers


RUN <<"EOF"
cd /
sudo -n wget https://raw.githubusercontent.com/mirage335-colossus/ubiquitous_bash/master/ubiquitous_bash.sh
sudo -n chmod 755 /ubiquitous_bash.sh
#/ubiquitous_bash.sh _setupUbiquitous
sudo -n /ubiquitous_bash.sh _setupUbiquitous
/ubiquitous_bash.sh _custom_splice_opensslConfig
EOF


# Build arguments to set UID and GID at build time:
# e.g. docker build --build-arg HOST_UID=$(id -u) --build-arg HOST_GID=$(id -g) -t my_image:latest .
ARG HOST_UID=1000
ARG HOST_GID=1000
ARG USERNAME=containeruser

RUN echo 'HOST_UID= '"$HOST_UID" > /info

# Create a matching group and user, and a corresponding home directory
RUN groupadd --gid $HOST_GID $USERNAME && \
    useradd --uid $HOST_UID --gid $HOST_GID --create-home --shell /bin/bash $USERNAME

RUN usermod -aG sudo $USERNAME

# Set this user as default
USER $USERNAME

# Set HOME explicitly (usually set automatically, but good for clarity)
ENV HOME=/home/$USERNAME
ENV USER=$USERNAME


RUN mkdir -p /home/$USERNAME
RUN chown $USERNAME:$USERNAME /home/$USERNAME


RUN <<EOF
cp -a /ubiquitous_bash.sh /home/$USERNAME/ubiquitous_bash.sh
sudo -n chown $USERNAME:$USERNAME /home/$USERNAME/ubiquitous_bash.sh
cd /home/$USERNAME/
/home/$USERNAME/ubiquitous_bash.sh _setupUbiquitous
EOF



WORKDIR /currentPWD

#COPY . /app


#ENTRYPOINT ["/usr/local/bin/ubiquitous_bash.sh", "_drop_docker"]
#ENTRYPOINT ["bash", "-c", "echo ls / ; ls / ; echo ls ; ls ; echo $PWD"]
ENTRYPOINT ["/ubiquitous_bash.sh", "_bin"]



















