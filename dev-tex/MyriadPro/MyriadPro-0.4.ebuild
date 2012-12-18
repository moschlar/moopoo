# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit latex-package

DESCRIPTION="LaTeX support for Adobe's Pro opentype font Myriad Pro"
HOMEPAGE="https://github.com/sebschub/FontPro"
SRC_URI="https://github.com/sebschub/FontPro/archive/${PN}v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-text/acroread
	dev-texlive/texlive-genericextra
	dev-tex/fontaxes
	dev-tex/mdsymbol"
RDEPEND="${DEPEND}"

S=${WORKDIR}/FontPro-${PN}v${PV}

src_prepare() {
	mkdir $S/otf
	for i in `find /opt/Adobe/Reader9/Resource/Font/ -name 'MyriadPro*'`; do
		cp $i $S/otf
	done
}

src_compile() {
	./scripts/makeall MyriadPro
}

src_install() {
	./scripts/install ${D}/${TEXMF}
	rm ${D}/${TEXMF}/ls-R
	use doc && dodoc ./doc/MyriadPro.pdf
}
