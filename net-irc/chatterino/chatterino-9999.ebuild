# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

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

IUSE="streamlink pulseaudio gst-plugins-good"


RDEPEND="
	dev-qt/qtmultimedia
	dev-qt/qtconcurrent
	dev-qt/linguist-tools
	dev-qt/qtcore
	dev-libs/boost
	dev-libs/openssl
	streamlink? ( net-misc/streamlink )
	pulseaudio? ( media-libs/pulseaudio-qt )
	gst-plugins-good? ( media-libs/gst-plugins-good )"
BDEPEND="dev-util/cmake dev-vcs/git dev-qt/qtsvg ${DEPEND}"
DEPEND="${DEPEND}"

src_compile() {
	cd "${WORKDIR}/chatterino-9999"
	mkdir -p build
	cd build
	cmake ..
	if [ -z "$CCACHE_SLOPPINESS"]; then
		CCACHE_SLOPPINESS="pch_defines,time_macros"
		export CCACHE_SLOPPINESS
	fi
	emake
}

src_install() {
	install -Dm755 "build/bin/chatterino" "${D}/usr/bin/chatterino"
	install -Dm644 "resources/com.chatterino.chatterino.desktop" "${D}/usr/share/applications"
	install -Dm644 "resources/icon.png" "${D}/usr/share/pixmaps/chatterino.png"
}
