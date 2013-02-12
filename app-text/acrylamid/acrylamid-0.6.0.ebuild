# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A static blog compiler with incremental updates"
HOMEPAGE="http://posativ.org/acrylamid/"
SRC_URI="http://pypi.python.org/packages/source/a/acrylamid/acrylamid-0.6.0.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mako restructuredtext textile discount syntax unidecode pyyaml twitter"

DEPEND=""
RDEPEND="
	dev-python/jinja
	dev-python/markdown
	virtual/python-argparse
	mako? ( dev-python/mako )
	restructuredtext? ( dev-python/docutils )
	textile? ( app-text/pytextile )
	discount? ( app-text/discount )
	syntax? ( dev-python/pygments )
	unidecode? ( dev-python/unidecode )
	pyyaml? ( dev-python/pyyaml )
	twitter? ( dev-python/twitter )
	"

