#!/bin/bash

cd $(dirname $0)
source ./bash-plop/bash-plop.sh

PROJECT_DIRECTORY="../Philosophers"

plop_init
mkdir -p outs

plop_setup()
{
	PLOP_TEST_OUTPUT=$(printf "outs/test-%02d-tty.txt" $PLOP_TEST_NUM)
}

PLOP_DESCRIPTION="The program compiles"
plop_test_command make $PROJECT_DIRECTORY
[ $PLOP_EXIT_STATUS -eq 0 ] && PLOP_TEST_RESULT="OK" || PLOP_TEST_RESULT="KO"
plop_test_summary

PLOP_DESCRIPTION="The file philo/philo exists and is executable"
plop_test_command [ -x $PROJECT_DIRECTORY/philo/philo ]
[ $PLOP_EXIT_STATUS -eq 0 ] && PLOP_TEST_RESULT="OK" || PLOP_TEST_RESULT="KO"
plop_test_summary

printf "\nWhen running without any argument\n\n"

PLOP_DESCRIPTION="The program exits with status code = 1"
plop_test_command $PROJECT_DIRECTORY/philo/philo
[ $PLOP_EXIT_STATUS -eq 1 ] && PLOP_TEST_RESULT="OK" || PLOP_TEST_RESULT="KO"
plop_test_summary

PLOP_DESCRIPTION="A message is printed on stdout"
plop_test_command $PROJECT_DIRECTORY/philo/philo
[ -n "$(cat $PLOP_TEST_OUTPUT)" ] && PLOP_TEST_RESULT="OK" || PLOP_TEST_RESULT="KO"
plop_test_summary

plop_end
