# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils scons-utils

DESCRIPTION="rmlint finds space waste and other broken things on your filesystem and offers to remove it"
HOMEPAGE="http://rmlint.readthedocs.org/"
SRC_URI="https://github.com/sahib/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.32
	sys-apps/util-linux
	dev-libs/elfutils
	dev-libs/json-glib"
DEPEND="${RDEPEND}
	dev-python/sphinx"

src_configure() {
	MYSCONS=(
		"--prefix=${D}${DESTTREE}"
		"--actual-prefix=${DESTTREE}"
	)
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	escons "${MYSCONS[@]}" install
	rm "${D}/usr/share/glib-2.0/schemas/gschemas.compiled"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_prerm() {
	gnome2_schemas_update
}
