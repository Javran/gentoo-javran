# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/racket/racket-5.3.6.ebuild,v 1.1 2013/08/14 12:07:44 hkbst Exp $

EAPI="5"

# for live ebuilds uncomment inherit git-2, comment SRC_URI and empty KEYWORDS

inherit eutils
#inherit git-2

DESCRIPTION="Racket is a general-purpose programming language with strong support for domain-specific languages."
HOMEPAGE="http://racket-lang.org/"
SRC_URI="minimal? ( http://download.racket-lang.org/installers/${PV}/${PN}-minimal-${PV}-src-builtpkgs.tgz ) !minimal? ( http://download.racket-lang.org/installers/${PV}/${P}-src-builtpkgs-unix.tgz )"
#SRC_URI="http://pre.racket-lang.org/installers/plt-${PV}-src-unix.tgz"
EGIT_REPO_URI="git://git.racket-lang.org/plt.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc +futures +jit minimal +places +threads +X"

# see bug 426316: racket/draw (which depends on cairo) is sometimes used in compile-time code or when rendering documentation
RDEPEND="dev-db/sqlite:3 x11-libs/cairo[X?] virtual/libffi"
DEPEND="${RDEPEND}"

EGIT_SOURCEDIR="${WORKDIR}/${P}"
S="${WORKDIR}/${P}/src"

src_prepare() {
	#remove bundled libraries
	rm -rf foreign/libffi/
}

src_configure() {
# according to vapier, we should use the bundled libtool
# such that we don't preclude cross-compile. Thus don't use
# --enable-lt=/usr/bin/libtool
	econf \
		$(use_enable X gracket) \
		$(use_enable doc docs) \
		--enable-shared \
		$(use_enable jit) \
		--enable-foreign \
		$(use_enable places) \
		$(use_enable futures) \
		$(use_enable threads pthread)
}

src_install() {
	#racket now comes with desktop files, but DESTDIR is mishandled
	for f in /usr/share/applications/{drracket,slideshow}.desktop; do
		sed -ie "s|${D}||" ${D}/${f}
	done

	emake DESTDIR="${D}" install
}
