#!/bin/bash -e
set -x

texmf=/usr/share/texmf
enc=$texmf/fonts/enc/dvips
sty=$texmf/tex/latex
tfm=$texmf/fonts/tfm/public
vf=$texmf/fonts/vf/public
opentype=$texmf/fonts/opentype/public
map=$texmf/fonts/map/dvips
cmap=$texmf/fonts/cmap
type1=$texmf/fonts/type1/public

install() {
    sudo mkdir -p $1
    sudo cp -R ${@:2} $1
}

# Source Han Sans

echo yes | sudo cpan Data::Dump

cd ./SourceHanSans
mkdir -p out
cd out
pxcopyfont="perl ../PXcopyfont/pxcopyfont.pl"
$pxcopyfont upjpnrm-h sourcehans-j-jy2 r-sourcehans-j-jy2 r-sourcehans-j-jy2x
$pxcopyfont upjpnrm-h sourcehans-l-jy2 r-sourcehans-l-jy2 r-sourcehans-l-jy2x
$pxcopyfont upjpnrm-h sourcehans-r-jy2 r-sourcehans-r-jy2 r-sourcehans-r-jy2x
$pxcopyfont upjpnrm-h sourcehans-m-jy2 r-sourcehans-m-jy2 r-sourcehans-m-jy2x
$pxcopyfont upjpnrm-h sourcehans-d-jy2 r-sourcehans-d-jy2 r-sourcehans-d-jy2x
$pxcopyfont upjpnrm-h sourcehans-b-jy2 r-sourcehans-b-jy2 r-sourcehans-b-jy2x
$pxcopyfont upjpnrm-h sourcehans-h-jy2 r-sourcehans-h-jy2 r-sourcehans-h-jy2x

cd ..
install $opentype/sourcehans fonts
install $cmap/sourcehans ./UniSourceHanSansJP-UTF16-H/UniSourceHanSansJP-UTF16-H
install $sty/sourcehans ./UniSourceHanSansJP-UTF16-H/tcsourcehans.sty
install $tfm/sourcehans ./out/*.tfm 
install $vf/sourcehans ./out/*.vf


# Inconsolata

cd ../Inconsolata/inconsolata
install $enc/inconsolata enc/*.enc 
install $opentype/inconsolata opentype/*.otf
install $map/inconsolata map/*.map
install $tfm/inconsolata tfm/*.tfm
install $type1/inconsolata type1/*.pfb
install $sty/inconsolata tex/*

sudo mkdir -p /usr/share/texmf/web2c
sudo bash -c "echo 'Map zi4.map' >> /usr/share/texmf/web2c/updmap.cfg"

cd ../BXinconsolata
install $sty/BXinconsolata bxinconsolata.sty
install $tfm/BXinconsolata *.tfm
install $vf/BXinconsolata *.vf

sudo fc-cache -fv
sudo mktexlsr
sudo -H updmap-sys

