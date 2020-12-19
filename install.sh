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
#moving to src folder
cd src
#success message
echo Success! You can run ./run.sh to run the programme, or ruby cassandra.rb to run it with command line arguments.