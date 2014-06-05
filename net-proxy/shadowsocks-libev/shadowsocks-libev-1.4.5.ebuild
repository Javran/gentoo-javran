# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# modified version of:
# https://github.com/ritksm/ritksm-overlay/blob/master/net-proxy/shadowsocks-libev/shadowsocks-libev-1.4.4.ebuild

EAPI=5
inherit autotools autotools-utils eutils git-2

DESCRIPTION="libev port of shadowsocks http://shadowsocks.org"
HOMEPAGE="https://github.com/madeye/shadowsocks-libev"
EGIT_REPO_URI="git://github.com/madeye/shadowsocks-libev.git"
EGIT_COMMIT="v1.4.5"

SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/openssl
        dev-libs/libev
        net-libs/libasyncns
"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}
