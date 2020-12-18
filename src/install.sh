#!/bin/bash

#insatlling homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#installing ruby
brew install ruby
#cloning the repository to the local machine
git clone https://github.com/chivoi/cassandra.git
#install bundler
gem install bundler
#install gem dependencies
bundle install
#success message
echo Success!