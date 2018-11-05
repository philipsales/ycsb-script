#!/bin/bash

# import
. settings/config.cfg

DB=$REDIS_DB
TOTAL_RUN=$TOTAL_RUN

. $DB/truncate.sh
. $DB/load.sh
. $DB/run.sh

OUTPUT_DIR="$RESULTS_DIR/$DB"
mkdir -p $OUTPUT_DIR

echo ${DAT_FILES[*]}

for dat_file in ${DAT_FILES[*]}
do
    DAT_FILE=$dat_file

    counter=9
    echo $TOTAL_RUN

    until [ $counter -gt $TOTAL_RUN ]
    do
        cleartable
        wait
        loaddata "$OUTPUT_DIR" "$DB" "$counter" "$DAT_FILE"
        wait
        
        for workload in ${WORKLOADS[*]}
        do
            #workload A to D
            runtask "$OUTPUT_DIR" "$DB" "$counter" "$DAT_FILE" "$workload"
            wait
        done
        ((counter++))
        echo "counter: $counter"
    done
done

cd $SCRIPT_DIR
