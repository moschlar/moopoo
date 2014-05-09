# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils bash-completion-r1

DESCRIPTION="Git extensions to provide high-level repository operations for Vincent Driessen's branching model."
HOMEPAGE="https://github.com/nvie/gitflow"
SRC_URI="https://github.com/nvie/gitflow/tarball/0.4.1 -> ${P}.tar.gz
	bash-completion? ( https://github.com/bobthecow/git-flow-completion/tarball/0.4.1.0 -> ${P}-completion.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

DEPEND="dev-util/shflags"
RDEPEND="${DEPEND}
	|| ( >=dev-vcs/git-1.7.8 <dev-vcs/git-1.7.8[bash-completion?] )"

S="${WORKDIR}/nvie-gitflow-5b26edc"

src_prepare() {
	epatch "${FILESDIR}/system-shflags.patch"
}

src_compile() {
	true
}

src_install() {
	emake prefix="${D}" install
	if use bash-completion; then
		newbashcomp "${WORKDIR}/bobthecow-git-flow-completion-b399150/git-flow-completion.bash" git-flow
	fi
}

pkg_postinst() {
	if use bash-completion; then
		elog "Use eselect to activate the bash-completion module:"
		elog "    git-flow"
	fi
}
