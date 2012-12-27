# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit latex-package

DESCRIPTION="Additional font axes for LaTeX"
HOMEPAGE="http://ctan.tug.org/pkg/${PN}"
SRC_URI="http://mirror.ctan.org/systems/texlive/tlnet/archive/${PN}.tar.xz -> ${P}.tar.xz
	source? ( http://mirror.ctan.org/systems/texlive/tlnet/archive/${PN}.source.tar.xz -> ${P}.source.tar.xz )
	doc? ( http://mirror.ctan.org/systems/texlive/tlnet/archive/${PN}.doc.tar.xz -> ${P}.doc.tar.xz )"

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

S=${WORKDIR}

src_install() {
	insinto ${TEXMF}
	doins -r *
}
