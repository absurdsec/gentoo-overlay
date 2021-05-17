# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION='Second installment of the Twitch chat client series "Chatterino"'
HOMEPAGE="https://chatterino.com"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Chatterino/chatterino2"
else
	SRC_REPO_URI="https://github.com/Chatterino/chatterino2/archive/refs/tags/${PV}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"

IUSE="streamlink pulseaudio gst-plugins-good" # dbus" idk kev


RDEPEND="
	dev-qt/qtmultimedia
	dev-qt/qtconcurrent
	dev-qt/linguist-tools
	dev-qt/qtcore
	dev-libs/boost
	dev-libs/openssl
	streamlink? ( net-misc/streamlink )
	pulseaudio? ( media-libs/pulseaudio-qt )
	gst-plugins-good? ( media-libs/gst-plugins-good )
	dbus ( dev-qt/qtdbus ) "

BDEPEND="dev-util/cmake dev-vcs/git dev-qt/qtsvg ${DEPEND}"
DEPEND="${DEPEND}"

src_compile() {
	cd "${WORKDIR}/chatterino-9999" # this might fuckup
	mkdir -p build # not sure you need to do this
	cd build
	cmake ..
	emake
}

src_install() {
	cmake_src_install
}
