#!/bin/bash
## Colors for nice output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

PASSED=0
FAILED=0

test_case(){
    local name="$1"
    local command="$2"
    local expected_exit="${3:-0}"

    echo -n "Testing: $name"

    eval "$command > /dev/null 2>&1"
    local actual_exit=$?
    
    if [$actual_exit -eq $expected_exit]; then
        echo -e "${GREEN} PASS${NC}"
        ((PASSED++))
    else
        echo -e "${RED} FAIL${NC} (got exit ${actual_exit}, expected ${expected_exit})"
        ((FAILED++))
    fi

}

test_output(){
    local name="$1"
    local command="$2"
    local expected_output="${3}"

    echo -n "Testing: $name"
    
    local actual_output=$(eval "$command" 2>/dev/null)

    if [ "$actual_output" == "$expected_output" ]; then
        echo -e "${GREEN} PASS${NC}"
        ((PASSED++))
    else
        echo -e "${RED} FAIL${NC}"
        echo " Expected: '$expected_output'"
        echo " GOT: '$actual_output'"
        ((FAILED++))
    fi

}

test_db(){
    local name="$1"
    local command="$2"
    local expected_output="$3"
    
    echo "${name}"
    local output=$(eval "$command" 2>/dev/null)
    echo "${output}"
}


echo "=========================="
echo "Running Test Suite"
echo "=========================="

test_db "sq" "./a" "db >"


# Summary
echo "=========================="
echo -e "Results: ${GREEN}$PASSED${NC} passed, ${RED}$FAILED${NC} failed"
echo "=========================="

# # Exit with error if any test failed
 [ $FAILED -eq 0 ]

