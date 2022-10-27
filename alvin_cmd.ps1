#!/bin/bash

# Put all my custom command here

function hey(){
  echo "Test Success!"
}

function wpt(){
  third_party/blink/tools/run_web_tests.py -t Default $args[0]
}

function build(){
 if( $args[0] ){
   format 
   autoninja -C out/Default $args[0]
 }
 else{
   format
   autoninja -C out/Default chrome
 }
}

function format(){
 if ( $args[0] ){
   git cl format $args[0]
 }
 else{
   git cl format
 }
}

function upload(){
  git cl upload -T
  git cl try
}

function sync(){
  git pull
  gclient sync -D 
  build
}

function squash(){
  git rebase -i origin/HEAD
}
