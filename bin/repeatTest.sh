#!/usr/local/bin/bash

if [ $# -ne 3 ]; 
then
    echo "Usage : repeatTest.sh <TestCaseName> <RepeatCount> <PASS|FAIL>"
    echo "        Runs testcase <TestCaseName> <RepeatCount> tmes until it does <PASS|FAIL>"
    exit 1
fi

cleancore

count=1

echo ---------------------------------------------------------------
echo Running testcase $1 $2 times... until it does $3
echo ---------------------------------------------------------------

if [ $3 = 'PASS' ]; 
then 
    cond='FAIL' 
elif [ $3 = 'FAIL' ];
then
    cond='PASS'
else
    echo "Usage : repeatTest.sh <TestCaseName> <RepeatCount> <PASS|FAIL>"
    exit 1
fi

while [ $count -le $2 ]; do
    time=$(date | iconv -f euc-kr -t utf-8)
    echo -n "> Trial ${count} (${time}) : "
    atfrun $1 | grep "$cond\$"
    # grep 이 아무것도 못잡으면 에러(1), 뭔가 잡으면 성공(0) 리턴
    if [ $? -eq 1 ]; 
    then 
        echo "$3!"
        exit 1
    fi
    count=$(($count + 1))
done

