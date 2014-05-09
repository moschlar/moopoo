# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils bash-completion-r1

COMP_PN="git-flow-completion"
COMP_PV="0.5.1"
COMP_P="${COMP_PN}-${COMP_PV}"

DESCRIPTION="AVH Edition of the git extensions to provide high-level repository operations for Vincent Driessen's branching model"
HOMEPAGE="https://github.com/petervanderdoes/gitflow"
SRC_URI="https://github.com/petervanderdoes/gitflow/archive/${PV}.tar.gz -> ${P}.tar.gz
	bash-completion? ( https://github.com/petervanderdoes/git-flow-completion/archive/${COMP_PV}.tar.gz -> ${COMP_P}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="bash-completion"

PDEPEND="!dev-vcs/git-flow"
RDEPEND="${DEPEND}
	|| ( >=dev-vcs/git-1.7.8 <dev-vcs/git-1.7.8[bash-completion?] )"

src_compile() {
	true
}

src_install() {
	emake prefix="${D}" install
	if use bash-completion; then
		newbashcomp "${WORKDIR}/${COMP_P}/git-flow-completion.bash" git-flow
	fi
}

pkg_postinst() {
	if use bash-completion; then
		elog "Use eselect to activate the bash-completion module:"
		elog "    git-flow"
	fi
}
