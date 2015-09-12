# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit gnome2

DESCRIPTION="Write an ISO file to multiple USB devices at once "
HOMEPAGE="https://wiki.gnome.org/Apps/MultiWriter"
#SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
    >=dev-libs/glib-2.31.10:2
	>=dev-libs/libgusb-0.2.2
	sys-fs/udisks:2
	virtual/libgudev
    >=x11-libs/gtk+-3.11.2:3
	>=media-libs/libcanberra-0.10[gtk3]
"
DEPEND="${RDEPEND}
    dev-libs/appstream-glib
    >=dev-util/intltool-0.40.6
    sys-devel/gettext
    virtual/pkgconfig
"

