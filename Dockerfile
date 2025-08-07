ARG BASE_IMAGE_TAG=latest

# Stage 1: Use the original Gentoo stage3 image as a source
FROM docker.io/gentoo/stage3:${BASE_IMAGE_TAG} AS source

# Stage 2: Create a new image based on Gentoo stage3
FROM docker.io/gentoo/stage3:${BASE_IMAGE_TAG}

# Create the /mnt/target directory in the new image
RUN mkdir -p /mnt/target
RUN emerge-webrsync
RUN getuto

COPY package.use /etc/portage/package.use
COPY package.use /mnt/target/etc/portage/package.use
COPY make.conf /etc/portage/make.conf
COPY make.conf /mnt/target/etc/portage/make.conf
COPY initramfs /root/initramfs
RUN emerge --getbinpkg app-editors/vim sys-apps/busybox

# Copy all files from the source image's root to /mnt/target in the new image
# Exclude special filesystems to avoid issues
COPY --from=source / /mnt/target/

RUN rm -rf /mnt/target/share/doc /mnt/target/share/man

RUN emerge --getbinpkg sys-fs/squashfs-tools app-portage/eix app-portage/gentoolkit sys-kernel/gentoo-sources

RUN emerge --root=/mnt/target -C app-text/docbook-xml-dtd app-text/docbook-xsl-ns-stylesheets app-text/docbook-xsl-stylesheets app-text/opensp app-text/sgml-common sys-devel/gcc sys-apps/man-db sys-apps/man-pages app-text/manpager sys-apps/help2man
