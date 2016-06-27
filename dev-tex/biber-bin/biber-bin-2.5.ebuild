# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Biber is a BibTeX replacement for users of biblatex, with full Unicode support."
HOMEPAGE="http://biblatex-biber.sourceforge.net/ https://github.com/plk/biber/"
SRC_URI="mirror://sourceforge/biblatex-biber/biblatex-biber/current/binaries/biber-linux_x86_64.tar.gz"

LICENSE="|| ( Artistic-2 GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dobin biber
}
