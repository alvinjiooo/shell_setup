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

function bcros(){
   autoninja -C out_$BOARD/Release chrome
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
  git pull && gclient sync -D && build chrome
}

function squash(){
  git rebase -i origin/HEAD
}

function server(){
  http-server -S -C cert.pem -o -a localhost -p 8000 -c-1
}

function pserver(){
  python3 -m http.server 8080 -b 127.0.0.1
}

function addlog(){
  python3 ~/shell_setup/add_log.py "$1"
}

alias refcheck='gn refs out/Default $1 --type=executable --all'
