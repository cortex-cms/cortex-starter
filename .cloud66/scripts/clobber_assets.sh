#!/bin/bash
cd $STACK_PATH

bin/rails assets:clobber webpacker:clobber react_on_rails:assets:clobber
