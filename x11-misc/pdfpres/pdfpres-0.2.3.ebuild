# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"
inherit python

MY_PN="pdfPres"
GITHUB_USER="vain"
GITHUB_TAG="e01efb1"
DESCRIPTION="Dual head PDF presenter"
HOMEPAGE="http://www.uninformativ.de/projects/?q=pdfpres"
SRC_URI="https://github.com/${GITHUB_USER}/${MY_PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	app-text/poppler[cairo]
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${GITHUB_USER}-${MY_PN}-${GITHUB_TAG}"

#pkg_setup() {
#	python_set_active_version 2
#}

src_prepare() {
	python_convert_shebangs 2 legacy-notes-converter.py
}

src_install() {
	dodoc README || die

	newbin legacy-notes-converter.py ${PN}-legacy-notes-converter || die
	dobin ${PN} || die
	doman man1/${PN}.1 || die
}
