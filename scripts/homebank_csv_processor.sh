#!/bin/bash

STATEMENTS="./data/*.csv"
FILE="./data/data"

for f in $STATEMENTS; do
    sed -i 's/ianuarie/January/g;s/februarie/February/g;s/martie/March/g;s/aprilie/April/g;s/mai/May/g;s/iunie/June/g' $f
    sed -i 's/iulie/July/g;s/august/August/g;s/septembrie/September/g;s/octombrie/November/g;s/noiembrie/November/g;s/decembrie/December/g' $f
    awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", ".", $i) } 1' $f > tmp && mv tmp $f
done

echo "" > $FILE

grep -Pzoh "^[0-9]{2} [A-Za-z]+ [0-9]{4},,Cumparare[^,]+,,([0-9]+.[0-9]+),+\n,,Nr. card:([^,]+),+\n,,Terminal:([^,]+),+\n,,Data:([0-9]{2}-[0-9]{2}-[0-9]{4})" $STATEMENTS | sed -r 's/^,*//;s/,*$//;s/,{2,}/,/g' | sed 'N;s/\n/,/' | sed 'N;s/\n/,/' | sed -r 's/^([0-9]{2} [A-Za-z]+ [0-9]{4},Cumparare POS,)//;s/Nr. card://;s/Terminal://;s/Data://;s/^/Purchase,/' >> $FILE
grep -Pzoh "^[0-9]{2} [A-Za-z]+ [0-9]{4},,Retragere[^,]+,,([0-9]+.[0-9]+),+\n,,Nr. card:([^,]+),+\n,,Terminal:([^,]+),+\n,,Data:([0-9]{2}-[0-9]{2}-[0-9]{4})" $STATEMENTS | sed -r 's/^,*//;s/,*$//;s/,{2,}/,/g' | sed 'N;s/\n/,/' | sed 'N;s/\n/,/' | sed -r 's/^([0-9]{2} [A-Za-z]+ [0-9]{4},Retragere numerar,)//;s/Nr. card://;s/Terminal://;s/Data://;s/^/Withdrawal,/' >> $FILE
grep -Pzoh "^[0-9]{2} [A-Za-z]+ [0-9]{4},,Transfer Home'Bank,,([0-9]+.[0-9]+),+\n,,Beneficiar:([^,]+),+" $STATEMENTS | sed -r 's/^,*//;s/,*$//;s/,{2,}/,/g' | sed 'N;s/\n/,/' | sed -r 's/Transfer [^,]+,//;s/Beneficiar:/,/' | sed -r 's/(^[0-9]{2} [A-Za-z]+ [0-9]{4}),(.*)$/echo -n Transfer,\2,; date -d"\1" +%d-%m-%Y/e;' >> $FILE