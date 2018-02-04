# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit unpacker xdg-utils

DESCRIPTION="A hackable text editor for the 21st Century"
HOMEPAGE="https://atom.io/"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom-amd64.deb -> ${P}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="!app-editors/atom
	dev-vcs/git
	gnome-base/gconf
	x11-libs/gtk+:2
	virtual/libudev
	dev-libs/libgcrypt
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	dev-lang/python
	gnome-base/gvfs
	x11-misc/xdg-utils
	sys-libs/libcap"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${P}.deb"
}

src_install() {
	cp -a "${S}/usr" "${D}/"
}

pkg_postinst() {
	xdg_desktop_database_update
	default
}

pkg_postrm() {
	xdg_desktop_database_update
	default
}
