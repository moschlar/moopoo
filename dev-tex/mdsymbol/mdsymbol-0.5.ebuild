# Distributed under the terms of the GNU General Public License v3.
# $Header: $

EAPI=2

inherit latex-package

DESCRIPTION="Symbol fonts to match Adobe Myriad Pro."
HOMEPAGE="http://ctan.tug.org/pkg/mdsymbol"
SRC_URI="http://mirror.ctan.org/systems/texlive/tlnet/archive/mdsymbol.tar.xz -> mdsymbol-0.5.tar.xz
	source? ( http://mirror.ctan.org/systems/texlive/tlnet/archive/mdsymbol.source.tar.xz -> mdsymbol-0.5.source.tar.xz )
	doc? ( http://mirror.ctan.org/systems/texlive/tlnet/archive/mdsymbol.doc.tar.xz -> mdsymbol-0.5.doc.tar.xz )"
LICENSE="OFL"

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
	cp -R "${S}"/* "${D}"/usr/share/texmf-site/
}
