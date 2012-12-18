# Distributed under the terms of the GNU General Public License v3.
# $Header: $

EAPI=2

inherit latex-package

DESCRIPTION="Mathematical symbol font for Adobe MinionPro."
HOMEPAGE="http://www.ctan.org/"
#SRC_URI="http://mirror.ctan.org/systems/texlive/tlnet//archive/mdsymbol.tar.xz -> mdsymbol-28399.tar.xz source? ( http://mirror.ctan.org/systems/texlive/tlnet//archive/mdsymbol.source.tar.xz -> mdsymbol-28399.source.tar.xz ) doc? ( http://mirror.ctan.org/systems/texlive/tlnet//archive/mdsymbol.doc.tar.xz -> mdsymbol-28399.doc.tar.xz )"
SRC_URI="http://mirror.ctan.org/systems/texlive/tlnet//archive/mnsymbol.tar.xz -> mnsymbol-1.4.tar.xz"
LICENSE="OFL"

SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND=""
RDEPEND=""

S=${WORKDIR}

# Can go with EAPI=3
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

pkg_postinst() {
	elog
	elog "Note that the dependencies were not checked, so you"
	elog "might need to install other packages, too."

	latex-package_pkg_postinst
}

