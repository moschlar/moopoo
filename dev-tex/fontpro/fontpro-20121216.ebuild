# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vcs-snapshot latex-package

ACROREAD_LICENSE="Adobe"
ACROREAD_PV="9.5.1"
ACROREAD_P="AdbeRdr${ACROREAD_PV}-1_i486linux_enu"
ACROREAD_URI="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/${ACROREAD_PV}/enu/${ACROREAD_P}.tar.bz2"

DESCRIPTION="LaTeX support for Adobe's Pro opentype fonts Minion Pro, Myriad Pro, Cronos Pro and possibly more"
HOMEPAGE="https://github.com/sebschub/FontPro"
SRC_URI="https://github.com/sebschub/FontPro/archive/9842165801360eebb1b792551dd3e14f3063d9b2.tar.gz -> ${P}.tar.gz
	${ACROREAD_URI}"

LICENSE="public-domain ${ACROREAD_LICENSE}"
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

ACROREAD_S=${WORKDIR}/${ACROREAD_P}

src_unpack() {
	vcs-snapshot_src_unpack

	cd "${ACROREAD_S}" || die "cd failed"
	tar -xf COMMON.TAR Adobe/Reader9/Resource/Font || die "Failed to unpack COMMON.TAR."
}

prepare_font() {
	einfo "Preparing ${1}..."

	local SS
	SS=${WORKDIR}/${1}
	cp -r "${S}" "${SS}" || die "cp failed"

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
	einfo "Compiling ${1}..."

	local SS FONT_VER OPTS
	SS=${WORKDIR}/${1}
	cd "${SS}" || die "cd failed"

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
	einfo "Installing ${1}..."

	local SS
	SS=${WORKDIR}/${1}
	cd "${SS}" || die "cd failed"

	./scripts/install "${D}/${TEXMF}" || die "install failed"

	# Prevent overwriting the already installed ls-R file on merge
	rm "${D}/${TEXMF}/ls-R" || die "rm failed"

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
	latex-package_pkg_postinst

	elog
	use minionpro && elog "To use MinionPro, put \\usepackage{MinionPro} in the preamble of your LaTeX document."
	use myriadpro && elog "To use MyriadPro, put \\usepackage{MyriadPro} in the preamble of your LaTeX document."
	elog
}
