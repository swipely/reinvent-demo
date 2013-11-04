#!/bin/bash
sudo apt-get -y install rubygems
sudo gem install active_support --no-ri --no-rdoc --source http://rubygems.org
sudo gem install tzinfo --no-ri --no-rdoc --source http://rubygems.org
exit
