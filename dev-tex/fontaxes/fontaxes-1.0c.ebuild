# Distributed under the terms of the GNU General Public License v3.
# $Header: $

EAPI=2

inherit latex-package

DESCRIPTION="Additional font axes for LaTeX."
HOMEPAGE="http://ctan.tug.org/pkg/fontaxes"
SRC_URI="http://mirror.ctan.org/systems/texlive/tlnet//archive/fontaxes.tar.xz -> fontaxes-1.0c.tar.xz source? ( http://mirror.ctan.org/systems/texlive/tlnet//archive/fontaxes.source.tar.xz -> fontaxes-1.0c.source.tar.xz ) doc? ( http://mirror.ctan.org/systems/texlive/tlnet//archive/fontaxes.doc.tar.xz -> fontaxes-1.0c.doc.tar.xz )"
LICENSE="LPPL-1.21.3"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc source"
DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	for i in ${A}
	do
		xz -dc -- "${DISTDIR}/${i}" | tar xof - || die
	done
}

src_install() {
	dodir /usr/share/texmf-site/
	cp -R "${S}"/* "${D}"//usr/share/texmf-site//
}
