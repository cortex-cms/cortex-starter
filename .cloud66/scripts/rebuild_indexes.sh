#!/bin/bash
cd $STACK_PATH

bin/rails cortex:rebuild_indexes
