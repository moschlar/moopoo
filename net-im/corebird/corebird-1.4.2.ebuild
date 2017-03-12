# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/corebird/corebird-0.8.ebuild,v 1.1 2014/07/30 14:31:51 dlan Exp $

EAPI=5

VALA_MIN_API_VERSION=0.28

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit eutils autotools-utils gnome2 vala

DESCRIPTION="Native GTK+3 Twitter client"
HOMEPAGE="http://corebird.baedert.org/"
SRC_URI="https://github.com/baedert/corebird/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gstreamer spellcheck"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.44:2
	dev-libs/json-glib
	gstreamer? ( media-plugins/gst-plugins-meta:1.0[X,ffmpeg] )
	spellcheck? ( >=app-text/gspell-1.0 )
	>=net-libs/libsoup-2.42.3.1
	>=net-libs/rest-0.7.91:0.7
	>=x11-libs/gtk+-3.18:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.40
	sys-apps/sed
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-am-prog-valac-0.34.patch"
	sed -i -e "/manpagedir/s/manpagedir.*/&\/man1/g" data/Makefile.am || die
	autotools-utils_src_prepare
	gnome2_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(usex gstreamer "" --disable-video)
		--disable-gst-check
		$(usex spellcheck "" --disable-spellcheck)
	)
	gnome2_src_configure "${myeconfargs[@]}"
}