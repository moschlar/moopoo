# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools eutils gnome2

DESCRIPTION="Simple LaTeX editor for GTK+ 3 users"
HOMEPAGE="https://github.com/aitjcize/Gummi"
SRC_URI="https://github.com/aitjcize/Gummi/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

LANGS="ar ca cs da de el es fr hu it nl pl pt_BR pt ro ru sv zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND=">=dev-libs/glib-2.20:2
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexextra
	>=x11-libs/gtk+-3.4.0:3
	app-text/poppler[cairo]
	x11-libs/gtksourceview:3.0
	x11-libs/pango	
	app-text/gtkspell:3"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog README.md )

S="${WORKDIR}/Gummi-0.7.4"

src_prepare() {
	strip-linguas ${LANGS}
	eautoreconf
}

#pkg_postinst() {
#	gnome2_icon_cache_update
#	elog "Gummi >= 0.4.8 supports spell-checking through gtkspell. Support for"
#	elog "additional languages can be added by installing myspell-** packages"
#	elog "for your language of choice."
#}

#pkg_postrm() {
#	gnome2_icon_cache_update
#}
