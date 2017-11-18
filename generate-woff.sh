#!/bin/bash -e

f=0
if ! which pyftsubset 1>/dev/null 2>&1; then
    echo 'pip3 install pyftsubset brotli'
    exit 1
fi

mkdir -p out
cat face/{ascii,basic,1,2}.txt > out/chars.txt
pyftsubset SourceHanSans/fonts/SourceHanSansJP-Regular.otf --text-file=out/chars.txt --layout-features='*' --flavor=woff2 --output-file=out/SourceHanSansJP-Regular.min.woff2

