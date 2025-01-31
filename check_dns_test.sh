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
run_test "2"
run_test "2" www.italia.it 146.75.55.11 8.8.8.8 3.3.3.3
#test inerenti al corretto inserimento dei comandi
run_test "2" .italia.it 146.75.55.10 8.8.8.8
run_test "2" www.it 146.75.55.10 8.8.8.8
run_test "2" www.italia.gov 146.75.55.10 8.8.8.8
run_test "2" www.italia.it 1462.75.55.10 8.8.8.8
run_test "2" www.italia.it 5.55.10 8.8.8.8
run_test "2" www.italia.it 146.75.55.10.4 8.8.8.8

run_test "2" www.italia.it 146.75.55.10 8888.8.8.8
run_test "2" www.italia.it 146.75.55.10 8.8.8
run_test "2" www.italia.it 146.75.55.10 8.8.8.8.8

run_test "0" www.italia.it 146.75.55.10 8.8.8.8.8 "A"
run_test "1" www.italia.it 146.75.55.10 8.8.8.8.8 "MZ"
run_test "0" www.italia.it adobe-aem.map.fastly.net. 8.8.8.8.8 "MZ"
run_test "1" www.italia.it adobe-aem.map.fastly.net. 8.8.8.8.8
run_test "1" asdhcyawgfjaf adobe-aem.map.fastly.net. 8.8.8.8.8