# /usr/bin/env bash

pyret_string=$1
image_file=$2

echo pyret_string is $pyret_string

echo image_file is $image_file

rm -fr $image_file

tmpf=$(mktemp chart-image-gen-XXXXXX.arr)

cat > $tmpf <<EOF
import csv as csv
import charts as VC
import image-typed as I

$pyret_string

I.save-image(rendered.get-image(), '$image_file')
EOF

sed -i -e 's/ end\([ ,)]\)/ end\1\n/g' $tmpf

pyret $tmpf
