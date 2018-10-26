#!/bin/bash

function cleartable() {
    . settings/couchbase2.cfg

    COUCHBASE_APP="Couchbase\ Server.app"
    CLI_DIR="/Applications/$COUCHBASE_APP/Contents/Resources/couchbase-core/bin/"

    echo "Y" | eval $CLI_DIR/couchbase-cli bucket-flush \
        -c 127.0.0.1:8091 \
        --bucket=$BUCKET \
        -u $USERNAME \
        -p $PASSWORD \
        --enable-flush=1 
}
