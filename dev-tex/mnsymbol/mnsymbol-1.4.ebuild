# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit latex-package

DESCRIPTION="Mathematical symbol font for Adobe MinionPro"
HOMEPAGE="http://ctan.tug.org/pkg/${PN}"
SRC_URI="http://mirror.ctan.org/systems/texlive/tlnet/archive/${PN}.tar.xz -> ${P}.tar.xz
	source? ( http://mirror.ctan.org/systems/texlive/tlnet/archive/${PN}.source.tar.xz -> ${P}.source.tar.xz )
	doc? ( http://mirror.ctan.org/systems/texlive/tlnet/archive/${PN}.doc.tar.xz -> ${P}.doc.tar.xz )"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

S=${WORKDIR}

src_install() {
	# latex-package_src_doinstall doesn't work here,
	# because it excepts all files in $S ('-maxdepth 1')
	insinto /usr/share/texmf-site/
	doins -r *

	echo "MixedMap ${PN}.map" >> "${T}/${PN}.cfg"
	insinto /etc/texmf/updmap.d
	doins "${T}/${PN}.cfg"
}
