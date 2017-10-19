#!/usr/local/bin/bash

if [ $# -ne 3 ];
then
    echo "Usage: mergetrc <src_dir> <capt|appl> <dst_dir>"
    exit 1
fi

src_dir=$1
name=$2
dst_dir=$3

# 번호 붙은 trc 파일

files=$(ls $src_dir -1 | grep "$name.[0-9]" | sort -n -t'.' -k3)

rm -f $dst_dir/$name.trc
touch $dst_dir/$name.trc

for i in $files;
do
    cat "$src_dir/$i" >> $dst_dir/$name.trc
done

# 마지막 남은 번호 안붙은 trc 파일

file=$(ls $src_dir -1 | grep ".$name.trc")

cat "$src_dir/$file" >> $dst_dir/$name.trc

