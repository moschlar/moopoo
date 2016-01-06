# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit eutils multilib python

MY_P="wxGlade-${PV}"

DESCRIPTION="Glade-like GUI designer which can generate Python, Perl, C++ or XRC code"
HOMEPAGE="http://wxglade.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxglade/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-python/wxpython:3.0"

S="${WORKDIR}/${MY_P}"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	epatch "${FILESDIR}"/${P}-wxversion.patch
}

src_compile() {
	:
}

src_install() {
	dodoc CHANGES.txt NEWS.txt README.txt TODO.txt
	newicon icons/icon.xpm wxglade.xpm || die "installing wxglade.xpm failed"
	doman "${S}"/docs/man/wxglade.1 || die "installing man failed"
	rm -rf "${S}"/docs/man
	dohtml -r "${S}"/docs/* || die "installing docs failed"
	rm -rf "${S}"/docs

	python_copy_sources

	installation() {
		pydir=$(python_get_sitedir)/${PN}
		insinto "${pydir}"
		doins "${S}"/CREDITS.txt || die "installing credits.txt failed"
		doins -r ./* || die "installing failed"
		dosym /usr/share/doc/${PF}/html "${pydir}"/docs || die "doc symlink failed"
		fperms 775 "${pydir}"/wxglade.py
		dosym "${pydir}"/wxglade.py /usr/bin/wxglade-$(python_get_version) \
			|| die "main symlink failed"
	}
	python_execute_function -s installation

	python_generate_wrapper_scripts -E -f -q "${D}"usr/bin/wxglade

	make_desktop_entry wxglade wxGlade wxglade "Development;GUIDesigner"
}

pkg_postinst() {
	python_mod_optimize wxglade
}

pkg_postrm() {
	python_mod_cleanup wxglade
}
