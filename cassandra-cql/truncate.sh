#!/bin/bash

function cleartable() {
    echo "use ycsb; TRUNCATE ycsb.usertable; exit" | cqlsh --cqlversion=3.4.2
}
