#!/bin/bash


run(){
    ./check_dns.sh "$@"
}

assert()
{
    if [[ "$2" == "$3" ]]
    then
        echo "Test: OK"
    else
        echo "Test: KO"
    fi
}

run_test(){
    RETURN_CODE="$1"
    shift 1
    echo "Running test with some params: $@. Exit code should be $RETURN_CODE."
    run "$@"
    assert "$RETURN_CODE"
    echo "Test done."
}

run_test "0" www.italia.it 146.75.55.10 8.8.8.8
run_test "1" www.italia.it 146.75.55.11 8.8.8.8

