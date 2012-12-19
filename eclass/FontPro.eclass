# This eclass contains all common steps which have to be performed to
# get the otf files and generate the LaTeX font definitions for them.
# An ebuild should only specify the correct font name as $PN and the font
# version as $FONT_VER

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

	cd "${ACROREAD_S}"
	tar xf COMMON.TAR || die "Failed to unpack COMMON.TAR."
}

FontPro_src_prepare() {
	# Copy otf files from Adobe Reader
	mkdir "$S/otf"
	for i in `find "${ACROREAD_S}/Adobe/Reader9/Resource/Font/" -name "${PN}*.otf"`; do
		cp "$i" "$S/otf"
	done
}

FontPro_src_compile() {
	# This is not reliable, so we use a static font version number in the meantime
	#local FONT_VER
	#FONT_VER=$(otfinfo -v "${S}/otf/${PN}-Regular.otf" | sed -e 's/^Version \([[:digit:]]*\.[[:digit:]]*\);.*$/\1/')
	./scripts/makeall ${PN} --pack="${S}/scripts/${PN}-glyph-list-${FONT_VER}"
}

FontPro_src_install() {
	./scripts/install "${D}/${TEXMF}"
	# Prevent overwriting the already installed ls-R file on merge
	rm "${D}/${TEXMF}/ls-R"
	use doc && dodoc ./tex/${PN}.pdf
}

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install
