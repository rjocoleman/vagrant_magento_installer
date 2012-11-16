Vagrant Magento Installer
===


This is a frontend to my [vagrant_magento](https://github.com/rjocoleman/vagrant_magento) cookbook.  
It's designed to automatically get the cookbook and a vagrantfile down for an existing Magento project (or fresh source download).

When used with the included installer it will work with your current VCS. (i.e. This repo's `.git` folder is removed to prevent pollution).

My [vagrant_magento](https://github.com/rjocoleman/vagrant_magento) cookbook installs Apache, PHP, MySQL sever and required modules for deployment with Magento. It also configures Apache VirtualHosts to have you up an running in a virtualised environment in a flash.  


Dependancies
------------

* [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org)


What happens
------------
1. This repository's source is checked out via git to /tmp.
2. A gitignore is created (or your existing one is appeneded) to exclude the temp directories created.
3. Support files like `README.md` and `install.sh` are removed. This repo's `.git` folder is removed. 
4. The `Vagrantfile`, chef cookbooks and support files are copied to your current directory.


Usage
-----

Run this one-liner (in your project's root directory)  
`$ \curl -L http://mage.rjoc.me | bash `  
_Point to be noted is, there is a backslash before __curl__. This prevents misbehaving if you have aliased it with configuration in your ~/.curlrc file._  

Edit your new `Vagrantfile` or go straight to `$ vagrant up`.  
Point your browser to `http://localhost:1080/`  

Todo
----

* Remove install.sh's dependance on Git?


Known Issues
------------

* Magento localhost admin login cookie issue on some browsers. i.e. http://www.aschroder.com/2009/05/fixing-magento-login-problem-after-a-fresh-installation/
+ Potential solutions; use hostname with dots in it or override the core code that presents the issue.

Only tested on Mac OS X 10.8. Unlikely to work on Windows without a complete rewrite.


Contributing
------------

Please be aware that the `vagrant_magento` cookbook is provided in this repo for convenience only, contribs and issues for it should be focused here: https://github.com/rjocoleman/vagrant_magento


* File bug reports via GitHub issues.
* Pull requests are welcome.


1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



License and Author
===================

* Author:: Robert Coleman <github@robert.net.nz>
* Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.