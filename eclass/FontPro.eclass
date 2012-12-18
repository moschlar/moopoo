
inherit latex-package

#DESCRIPTION="LaTeX support for Adobe's Pro opentype font Minion Pro"
HOMEPAGE="https://github.com/sebschub/FontPro"
SRC_URI="https://github.com/sebschub/FontPro/archive/${PN}v${PV}.tar.gz"

LICENSE=""

IUSE="doc"

DEPEND="app-text/acroread
	dev-texlive/texlive-genericextra
	dev-tex/fontaxes"
RDEPEND="${DEPEND}"

S=${WORKDIR}/FontPro-${PN}v${PV}

FONTDIR="/opt/Adobe/Reader9/Resource/Font/"

FontPro_src_prepare() {
	mkdir $S/otf
	for i in `find ${FONTDIR} -name "${PN}*.otf"`; do
		cp $i $S/otf
	done
}

FontPro_src_compile() {
	./scripts/makeall ${PN}
}

FontPro_src_install() {
	./scripts/install ${D}/${TEXMF}
	rm ${D}/${TEXMF}/ls-R
	use doc && dodoc ./tex/${PN}.pdf
}

EXPORT_FUNCTIONS src_prepare src_compile src_install
