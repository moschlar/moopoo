inherit eutils latex-package

# All acroread related stuff is gracefully stolen from app-text/acroread/acroread-9.5.1-r1.ebuild
ACROREAD_LICENSE="Adobe"
ACROREAD_PV="9.5.1"
ACROREAD_URI="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/${ACROREAD_PV}/enu/AdbeRdr${ACROREAD_PV}-1_i486linux_enu.tar.bz2"

DESCRIPTION="LaTeX support for Adobe's Pro opentype font ${PN}"
HOMEPAGE="https://github.com/sebschub/FontPro"
SRC_URI="https://github.com/sebschub/FontPro/archive/${PN}v${PV}.tar.gz
	${ACROREAD_URI}"

LICENSE="${ACROREAD_LICENSE}"

IUSE="doc"

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
	mkdir "$S/otf"
	for i in `find "${ACROREAD_S}/Adobe/Reader9/Resource/Font/" -name "${PN}*.otf"`; do
		cp "$i" "$S/otf"
	done
}

FontPro_src_compile() {
	local FONT_VER
	FONT_VER=$(otfinfo -v "${S}/otf/${PN}-Regular.otf" | sed -e 's/^Version \([[:digit:]]*\.[[:digit:]]*\);.*$/\1/')
	./scripts/makeall ${PN} --pack="${S}/scripts/${PN}-glyph-list-${FONT_VER}"
}

FontPro_src_install() {
	./scripts/install "${D}/${TEXMF}"
	rm "${D}/${TEXMF}/ls-R"
	use doc && dodoc ./tex/${PN}.pdf
}

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install
