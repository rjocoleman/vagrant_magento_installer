#!/usr/bin/env bash

log()  { printf "$*\n" ; return $? ;  }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

usage()
{
  printf "%b" "

Usage

  install.sh [action]

Actions

  [help] - Display CLI help (this output)
  [[--]install-mage] <branch> - Install Magento version (NOTE: EXPERIMENTAL)

Defaults:

    branch: magento-1.7

"
}

check_librarian-chef() {
	log "Checking for Librarian-Chef"
	hash librarian-chef 2>&- || log "WARN: librarian-chef is not installed, can't update Cookbooks. (https://github.com/applicationsonline/librarian)"
}
check_git() {
	log "Checking for Git"
	hash git 2>&- || fail "Git is not installed!"
}

# work happens below
here=$(pwd -P)
tmp="/tmp/vagrant_magento_installer"
check_git

# Parse CLI arguments.
while (( $# > 0 ))
do
  token="$1"
  option="$2"
  shift
  case "$token" in

    --install-mage|install-mage) # Install Magento from a given branch
	case "$option" in
	    --branch|branch) # Install Magento from a given branch
	      if [[ -n "${2}" ]]
	      then
		  	branch="$2"
	        shift
	      else
	        fail "--branch must be followed by a branchname."
	      fi
	  esac
	  log "Installing LokeyCoding/magento-mirror --branch ${branch:-magento-1.7}"
	  git clone git://github.com/LokeyCoding/magento-mirror.git --branch ${branch:-magento-1.7} $tmp
	  if [ "$?" -ne 0 ]; then fail "git clone failed"; exit 1; fi 
	  rm -rf $tmp/.git

	  cp -r $tmp/ $here/ &> /dev/null
	  rm -rf $tmp
	  shift
	  ;;

    help|usage)
      usage
      exit 0
      ;;
  *)
    usage
    exit 1
    ;;

  esac
done

check_librarian-chef

git clone git://github.com/rjocoleman/vagrant_magento_installer.git $tmp >/dev/null 2>&1
rm -rf $tmp/.git
rm -f $tmp/README* $tmp/install.sh
cat $tmp/.gitignore >> $here/.gitignore
rm -rf $tmp/.gitignore

cp -r $tmp/ $here/ &> /dev/null
rm -rf $tmp

if [[ ! -f librarian-chef ]]
then
  log "Updating cookbooks" 
  cd $here 
  librarian-chef update
  log "Updating cookbooks complete"
fi

log "Done! For more info visit:"
log "http://github.com/rjocoleman/vagrant_magento_installer"
exit 0