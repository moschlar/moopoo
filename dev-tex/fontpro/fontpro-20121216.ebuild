# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils latex-package

# All acroread related stuff is gracefully stolen from app-text/acroread/acroread-9.5.1-r1.ebuild
ACROREAD_LICENSE="Adobe"
ACROREAD_PV="9.5.1"
ACROREAD_URI="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/${ACROREAD_PV}/enu/AdbeRdr${ACROREAD_PV}-1_i486linux_enu.tar.bz2"

DESCRIPTION="LaTeX support for Adobe's Pro opentype fonts Minion Pro, Myriad Pro, Cronos Pro and possibly more"
HOMEPAGE="https://github.com/sebschub/FontPro"
GIT_REV="9842165801360eebb1b792551dd3e14f3063d9b2"
SRC_URI="https://github.com/sebschub/FontPro/archive/${GIT_REV}.tar.gz -> ${P}.tar.gz
	${ACROREAD_URI}"

# FontPro does not have any particular license so we just stick with the Adobe license
LICENSE="${ACROREAD_LICENSE}"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +minionpro +myriadpro +pack"
REQUIRED_USE="|| ( minionpro myriadpro )"
RESTRICT="mirror bindist"

# dev-texlive/texlive-genericextra contains fltpoint.sty
DEPEND="app-text/lcdf-typetools
	app-text/texlive-core
	dev-tex/fontaxes
	dev-texlive/texlive-genericextra
	minionpro? ( dev-tex/mnsymbol )
	myriadpro? ( dev-tex/mdsymbol )
	!dev-tex/MyriadPro
	!dev-tex/MinionPro"
RDEPEND="${DEPEND}"

S=${WORKDIR}/FontPro-${GIT_REV}
ACROREAD_S=${WORKDIR}/AdobeReader

src_unpack() {
	default_src_unpack

	cd "${ACROREAD_S}" || die "cd failed"
	tar xf COMMON.TAR Adobe/Reader9/Resource/Font || die "Failed to unpack COMMON.TAR."
}

prepare_font() {
	local SS
	SS=${WORKDIR}/${1}
	cp -r "${S}" "${SS}"

	# Copy otf files from Adobe Reader
	mkdir "${SS}/otf" || die "mkdir failed"
	find "${ACROREAD_S}/Adobe/Reader9/Resource/Font/" -name "${1}*.otf"\
		-exec cp '{}' "${SS}/otf" ';' || die "cp failed"
}

src_prepare() {
	use minionpro && prepare_font MinionPro
	use myriadpro && prepare_font MyriadPro
}

compile_font() {
	local SS FONT_VER OPTS
	SS=${WORKDIR}/${1}
	cd "${SS}"

	if use pack; then
		if [ -f "${SS}/otf/${1}-Regular.otf" ]; then
			# The following might not work reliable for otf files *not* from the Adobe Reader package,
			# but that doesn't bother us here at the moment
			FONT_VER=$(otfinfo -v "${SS}/otf/${1}-Regular.otf" | sed -e 's/^Version \([[:digit:]]*\.[[:digit:]]*\);.*$/\1/')
			OPTS="--pack=${SS}/scripts/${1}-glyph-list-${FONT_VER}"
		else
			ewarn "Could not determine font version - not packing glyphs"
		fi
	fi
	./scripts/makeall ${1} ${OPTS} || die "makeall failed"
}

src_compile() {
	use minionpro && compile_font MinionPro
	use myriadpro && compile_font MyriadPro
}

install_font() {
	local SS
	SS=${WORKDIR}/${1}
	cd "${SS}"

	./scripts/install "${D}/${TEXMF}" || die "install failed"
	# Prevent overwriting the already installed ls-R file on merge
	rm "${D}/${TEXMF}/ls-R"

	if use doc; then
		# Inspired by latex-package.eclass
		insinto "/usr/share/doc/${PF}"
		doins "${SS}/tex/${1}.pdf"
		dosym "/usr/share/doc/${PF}/${1}.pdf" "${TEXMF}/doc/latex/${1}/${1}.pdf"
	fi
}

src_install() {
	use minionpro && install_font MinionPro && echo "MixedMap MinionPro.map" >> "${T}/55fontpro.cfg"
	use myriadpro && install_font MyriadPro && echo "MixedMap MyriadPro.map" >> "${T}/55fontpro.cfg"
	insinto /etc/texmf/updmap.d
	doins "${T}/55fontpro.cfg"
}

pkg_postinst() {
	elog
	use minionpro && elog "To use MinionPro, put \\usepackage{MinionPro} in the preamble of your LaTeX document."
	use myriadpro && elog "To use MyriadPro, put \\usepackage{MyriadPro} in the preamble of your LaTeX document."
	elog
}
