#!/usr/local/bin/bash
#
# 1000 개 만큼의 trace 를 확보할 때까지 계속해서 Savepoint3.tc 를
# 반복수행한다.
#

if [ $# -ne 1 ]; 
then
    echo "Usage : repeat_and_gather_res.sh <cnt>"
    exit 1
fi

trial_cnt_max=$1

echo "==============================================================="
echo "Starting script to gather $trial_cnt_max instances of fail."
echo "==============================================================="

res_dir_root=${ADI_TEST}/trials/

echo "Cleaning up result directory :"

echo "    rm -rf $res_dir_root"
if [ -d $res_dir_root ];
then
    echo "    directory exists."
    exit 1
fi

rm -rf $res_dir_root

echo "Making result directory :"
echo "    mkdir $res_dir_root"
mkdir $res_dir_root

trial_cnt=1
temp_cnt=1

while [ $trial_cnt -le $trial_cnt_max ]; do

    echo "==============================================================="
    echo "Setting up test env : SetupO2A.ts"
    echo "==============================================================="
    atfrun ${ADI_TEST}/Setup/SetupO2A.ts

    while [ $temp_cnt -le 5 ]; do

        echo "==============================================================="
        echo "Trial $trial_cnt starts."
        echo "==============================================================="

        echo "Running repeatTest.sh"
        repeatTest.sh Savepoint3.tc 1000 FAIL

        if [ $? -eq 1 ];
        then
            res_dir=$res_dir_root/trial$trial_cnt
            mkdir $res_dir

            echo "Trial $trial_cnt FAILED!!."
            echo "Gathering traces and staging store to $res_dir"

            echo "Running mergetrc.sh"
            mergetrc.sh ${ADI_TEST}/itg1/trc capt $res_dir
            mergetrc.sh ${ADI_TEST}/itg2/trc appl $res_dir

            echo "Copying stg files"
            cp ${ADI_TEST}/itg1/stg/S1.stg $res_dir/S1.capt.stg
            cp ${ADI_TEST}/itg1/stg/S1.anc $res_dir/S1.capt.anc

            cp ${ADI_TEST}/itg2/stg/S1.stg $res_dir/S1.appl.stg
            cp ${ADI_TEST}/itg2/stg/S1.anc $res_dir/S1.appl.anc

            echo "Copying tc, lst, out files"
            cp ${ADI_TEST}/Basics/2_BasicOperationFlow/2_6_DCLTest/Savepoint3.* $res_dir

            trial_cnt=$(($trial_cnt + 1))
        fi

    done

    echo "==============================================================="
    echo "Shutting down dstabases"
    echo "==============================================================="
    atfrun ${ADI_TEST}/Setup/DatabaseShutdown.tc
    echo "==============================================================="
    echo "Cleaning up shared mem"
    echo "==============================================================="
    ${ADI_TEST}/Bugs/ipcclean.sh

    echo "==============================================================="
    echo "Clearing testenv"
    echo "==============================================================="
    killall -9 altibase

    echo Removing ${ADI_TEST}/alti*
    rm -rf ${ADI_TEST}/alti*

    echo Removing ${ADI_TEST}/ora*
    rm -rf ${ADI_TEST}/ora*

    echo Removing ${ADI_TEST}/itg*
    rm -rf ${ADI_TEST}/itg*

done

