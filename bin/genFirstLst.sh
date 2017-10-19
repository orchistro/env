#!/usr/local/bin/bash

#####################################################
#
# �׽�Ʈ���̽����� #@ �� ã�Ƽ�, ���� �����ϸ�
# ���ʷ� lst �� ����� �׽�Ʈ���̽��� �ν��ϰ�,
#   1. out ������ ���� ��
#   2. out ������ lst ���Ϸ� ����
#   3. �׽�Ʈ���̽����� #@ �� ����
#   4. �ٽ��ѹ� �׽�Ʈ���̽� ����
#   5. atfdiff ����
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

# ù��° ����
atfrun -f ${tc_filename}

# out file ����
cp ${out_filename} ${lst_filename}

# tc ���Ͽ��� @# ����
sed '/#@/d' ${tc_filename} > ${tc_filename}.new
mv ${tc_filename}.new ${tc_filename}

# �ѹ� �� ����
atfrun -f ${tc_filename}

# atfdiff
atfdiff -e ${test_type} ${tc_filename}

