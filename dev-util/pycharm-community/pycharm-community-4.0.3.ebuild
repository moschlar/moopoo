# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Intelligent Python IDE with unique code assistance and analysis (Community Edition)"
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/python/${P}.tar.gz"

LICENSE="Apache-2.0 BSD CDDL MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=""

RESTRICT="mirror strip"

MY_PN=${PN/-community/}

src_install() {
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/{pycharm.sh,fsnotifier{,64},inspect.sh}

	dosym /opt/${PN}/bin/pycharm.sh /usr/bin/${PN}
	newicon "bin/${MY_PN}.png" ${PN}.png
	make_desktop_entry ${PN} "PyCharm ${PV} Community Edition" "${PN}"
}
