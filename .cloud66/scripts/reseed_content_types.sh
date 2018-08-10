#!/bin/bash
cd $STACK_PATH

bin/rails cortex_starter:content_types:reseed
