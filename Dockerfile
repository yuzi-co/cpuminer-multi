# Usage: docker build .
# Usage: docker run tpruvot/cpuminer-multi -a xevan --url=stratum+tcp://yiimp.ccminer.org:3739 --user=iGadPnKrdpW3pcdVC3aA77Ku4anrzJyaLG --pass=x

FROM		ubuntu:18.04
MAINTAINER	Vadim Yuzi <vadim@yuzi.co>

RUN		apt-get update -qq

RUN		apt-get install -qy automake autoconf pkg-config libcurl4-openssl-dev libssl-dev libjansson-dev libgmp-dev libz-dev make g++ git

RUN		git clone --depth=1 https://github.com/yuzi-co/cpuminer-multi -b master

RUN		cd cpuminer-multi && ./build.sh

WORKDIR		/cpuminer-multi
ENTRYPOINT	["./cpuminer"]
