#!/bin/bash

# Put all my custom command here

function hey(){
  echo "Test Success!"
}

function wpt(){
  third_party/blink/tools/run_web_tests.py -t Default "$1"
}

function build(){
  format && autoninja -C out/Default "$1"
}

function format(){
 if [ -z "$1" ]
 then git cl format "$1"
 else git cl format
 fi
}

function upload(){
  git cl upload -T && git cl try
}

function sync(){
  git pull && gclient sync -D && build
}

function squash(){
  git rebase -i origin/HEAD
}
