# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils python-single-r1

RELEASE_TAG_NAME="3.1-latest"

DESCRIPTION="A simple C language RPC framework (including both server side & client side)"
HOMEPAGE="https://github.com/haiwen/libsearpc http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${RELEASE_TAG_NAME}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.26
	>=dev-libs/jansson-2.2.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/libsearpc.pc.patch
)

S="${WORKDIR}/${PN}-${RELEASE_TAG_NAME}"

