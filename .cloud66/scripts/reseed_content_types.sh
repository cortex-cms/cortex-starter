#!/bin/bash
cd $STACK_PATH

echo "Executing reseed_content_types in:"
pwd

bundle exec rake content_types:reseed
