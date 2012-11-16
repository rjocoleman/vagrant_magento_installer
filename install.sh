#!/usr/bin/env bash

log()  { printf "$*\n" ; return $? ;  }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

check_librarian-chef() {
	log "Checking for Librarian-Chef"
	hash librarian-chef 2>&- || log "WARN: librarian-chef is not installed, can't update Cookbooks. (https://github.com/applicationsonline/librarian)"
}
check_git() {
	log "Checking for Git"
	hash git 2>&- || fail "FATAL: Git is not installed!"
}

check_git
check_librarian-chef


here=$(pwd -P)
tmp="/tmp/vagrant_magento_installer"

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
log "http://github.com/rjocoleman/vagrant_magento_install"
exit 0