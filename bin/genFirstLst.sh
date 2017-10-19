#!/usr/local/bin/bash

#####################################################
#
# 테스트케이스에서 #@ 를 찾아서, 만약 존재하면
# 최초로 lst 를 만드는 테스트케이스로 인식하고,
#   1. out 파일을 만든 후
#   2. out 파일을 lst 파일로 복사
#   3. 테스트케이스에서 #@ 를 삭제
#   4. 다시한번 테스트케이스 실행
#   5. atfdiff 실행
#
#####################################################

if [ $# -ne 2 ];
then
    echo "Usage : generate_first_lst.sh <TestCaseName> <ExtensionName>"
    echo "ExtensionName : one of the followings"
    echo "    a2a a2o a2s a2u"
    echo "    o2a o2o o2s o2u"
    exit 1
fi

case $2 in
    a2a) echo "Test type : a2a";;
    a2o) echo "Test type : a2o";;
    a2s) echo "Test type : a2s";;
    a2u) echo "Test type : a2u";;
    o2a) echo "Test type : o2a";;
    o2o) echo "Test type : o2o";;
    o2s) echo "Test type : o2s";;
    o2u) echo "Test type : o2u";;
    *)
    echo "Allowed extension names are 'a2a a2o a2s a2u o2a o2o o2s o2u'"
    exit 1
esac

grep '#@' $1 > /dev/null
if [ $? -ne 0 ];
then
    echo "Testcase $1 is not just-created testcase."
    echo "If it is, put '#@' at the end of the file, and retry."
    exit 1
fi

tc_filename=$1
test_type=_$2
tc_name=${tc_filename/.tc/}
out_filename=${tc_name}".out"${test_type}
lst_filename=${tc_name}".lst"${test_type}

# 첫번째 실행
atfrun -f ${tc_filename}

# out file 복사
cp ${out_filename} ${lst_filename}

# tc 파일에서 @# 제거
sed '/#@/d' ${tc_filename} > ${tc_filename}.new
mv ${tc_filename}.new ${tc_filename}

# 한번 더 실행
atfrun -f ${tc_filename}

# atfdiff
atfdiff -e ${test_type} ${tc_filename}

