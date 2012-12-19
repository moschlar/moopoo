# This eclass contains all common steps which have to be performed to
# get the otf files and generate the LaTeX font definitions for them.
# An ebuild should only specify the correct font name as $PN

inherit eutils latex-package

# All acroread related stuff is gracefully stolen from app-text/acroread/acroread-9.5.1-r1.ebuild
ACROREAD_LICENSE="Adobe"
ACROREAD_PV="9.5.1"
ACROREAD_URI="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/${ACROREAD_PV}/enu/AdbeRdr${ACROREAD_PV}-1_i486linux_enu.tar.bz2"

DESCRIPTION="LaTeX support for Adobe's Pro opentype font ${PN}"
HOMEPAGE="https://github.com/sebschub/FontPro"
SRC_URI="https://github.com/sebschub/FontPro/archive/${PN}v${PV}.tar.gz
	${ACROREAD_URI}"

# FontPro does not have any particular license so we just stick with the Adobe license
LICENSE="${ACROREAD_LICENSE}"

IUSE="doc"

# dev-texlive/texlive-genericextra contains fltpoint.sty
DEPEND="app-text/lcdf-typetools
	app-text/texlive-core
	dev-tex/fontaxes
	dev-texlive/texlive-genericextra"
RDEPEND="${DEPEND}"

S="${WORKDIR}/FontPro-${PN}v${PV}"
ACROREAD_S="${WORKDIR}/AdobeReader"

FontPro_src_unpack() {
	default_src_unpack

	cd "${ACROREAD_S}" || die "cd failed"
	tar xf COMMON.TAR || die "Failed to unpack COMMON.TAR."
}

FontPro_src_prepare() {
	# Copy otf files from Adobe Reader
	mkdir "$S/otf" || die "mkdir failed"
	find "${ACROREAD_S}/Adobe/Reader9/Resource/Font/" -name "${PN}*.otf"\
		-exec cp '{}' "${S}/otf" ';' || die "cp failed"
}

FontPro_src_compile() {
	local FONT_VER
	# The following might not work reliable for otf files *not* from the Adobe Reader package,
	# but that doesn't bother us here at the moment
	FONT_VER=$(otfinfo -v "${S}/otf/${PN}-Regular.otf" | sed -e 's/^Version \([[:digit:]]*\.[[:digit:]]*\);.*$/\1/')

	./scripts/makeall ${PN} --pack="${S}/scripts/${PN}-glyph-list-${FONT_VER}" || die "makeall failed"
}

FontPro_src_install() {
	./scripts/install "${D}/${TEXMF}" || die "install failed"
	# Prevent overwriting the already installed ls-R file on merge
	rm "${D}/${TEXMF}/ls-R"

	use doc && dodoc ./tex/${PN}.pdf
}

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install
