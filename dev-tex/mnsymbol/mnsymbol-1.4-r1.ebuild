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
	# We move all files to the root directory and let the eclass do the magic
	find "${S}" -mindepth 2 -type f -execdir mv '{}' "${S}" ';' || die
	latex-package_src_install

	for i in `find . -maxdepth 1 -type f -name "*.map"`
	do
		insinto ${TEXMF}/fonts/map/dvips/${PN}
		doins $i || die "doins $i failed"
		echo "MixedMap ${i#./}" >> "${T}/${PN}.cfg" || die
	done

	insinto /etc/texmf/updmap.d
	doins "${T}/${PN}.cfg"
}
