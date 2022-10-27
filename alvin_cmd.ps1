function hey(){
  echo "Test Success!"
}

function wpt(){
  third_party/blink/tools/run_web_tests.py -t Default "$1"
}

function build(){
  (format) -and (autoninja -C out/Default "$1")
}

function format(){
 if ( -z "$1" ){
   git cl format "$1"
 }
 else{
   git cl format
 }
}

function upload(){
  (git cl upload -T) -and (git cl try)
}

function sync(){
  (git pull) -and (gclient sync -D) -and (build)
}

function squash(){
  git rebase -i origin/HEAD
}
