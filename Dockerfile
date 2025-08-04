# Stage 1: Use the original Gentoo stage3 image as a source
FROM gentoo/stage3:latest AS source

# Stage 2: Create a new image based on Gentoo stage3
FROM gentoo/stage3:latest

# Create the /mnt/target directory in the new image
RUN mkdir -p /mnt/target
RUN emerge-webrsync
RUN getuto
RUN emerge --getbinpkg app-editors/vim

# Copy all files from the source image's root to /mnt/target in the new image
# Exclude special filesystems to avoid issues
COPY --from=source / /mnt/target/

emerge -C app-text/docbook-xml-dtd app-text/docbook-xsl-ns-stylesheets app-text/docbook-xsl-stylesheets app-text/opensp app-text/sgml-common sys-devel/gcc sys-apps/man-db sys-apps/man-pages app-text/manpager sys-apps/help2man

rm -rf /mnt/target/share/doc /mnt/target/share/man

emerge --getbinpkg sys-fs/squashfs-tools app-portage/eix
