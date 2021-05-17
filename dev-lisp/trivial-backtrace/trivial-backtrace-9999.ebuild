# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3 eutils git-r3

DESCRIPTION="A simple library for generating a backtrace portably."
HOMEPAGE="http://common-lisp.net/project/trivial-backtrace
	https://github.com/gwkkwg/trivial-backtrace"
EGIT_REPO_URI="https://github.com/gwkkwg/trivial-backtrace.git"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

CLSYSTEMS="${PN} ${PN}-test"

src_install() {
	common-lisp-3_src_install
	dodoc *.config
}

