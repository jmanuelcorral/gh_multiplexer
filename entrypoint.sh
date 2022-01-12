#!/bin/bash

TestCollection=()

notStartsWithHash () {
    [[ $1 != "#"* ]]
}

isNotNullString () {
   [[ $1 != " "* && $1 != "" ]]  
}


process_line () {
    if notStartsWithHash $1
    then
        TestCollection+=(${1%$'\r'})
    fi
}

scan_tests () {
    readarray -t lines < $1
    i=0
    for line in ${lines[@]}; do
    process_line ${lines[$i]}
    i=$i+1
    done
}

main () {
   
   scan_tests $1
   collectionoutput=$(printf '%s\n' "${TestCollection[@]}" | jq -R . | jq -cs .)
   echo ::set-output name=list::"$collectionoutput"
}

main $1