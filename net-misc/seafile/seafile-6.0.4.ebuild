# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_{6,7} )
inherit autotools python-single-r1 vala

DESCRIPTION="File syncing and sharing software with file encryption and group sharing, emphasis on reliability and high performance"
HOMEPAGE="https://github.com/haiwen/seafile/ http://www.seafile.com/"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
    net-libs/libsearpc[${PYTHON_USEDEP}]
    =net-libs/ccnet-${PV}[${PYTHON_USEDEP}]
    >=dev-libs/glib-2.16.0:2
    >=dev-libs/libevent-2.0
	>=dev-libs/jansson-2.2.1
	>=sys-libs/zlib-1.2.0
	>=net-misc/curl-7.17
	dev-libs/openssl:0
    dev-db/sqlite:3"
DEPEND="${RDEPEND}
    $(vala_depend)"

src_prepare() {
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die
    default
    eautoreconf
	vala_src_prepare
}
