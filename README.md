# Cassandra: your most truthful fortune teller app

Cassandra tells you your fortune or who you were in your past life. After you've heard enough, you can look back at all of your fortunes and save them in a file.

To have a better experience, switch your terminal window to **full screen**.

Github repository: <https://github.com/chivoi/cassandra>

## Installation

To run the app you need to install Ruby, I used version 2.7.1. Head to [the docs](https://www.ruby-lang.org/en/documentation/installation/) for the detailed instrucitons.

Then, clone this repository to your local machine:
```
$ git clone https://github.com/chivoi/cassandra.git
```
Then, install the gem dependencies with [bundler](https://bundler.io/)
```
$ bundle install
```
...or any other way you prefer it. After this, you should be ready to go!

## Command line options

Cassandra accepts following command line arguments: 

- `-h` for programme info
- `-v` for Cassandra and Ruby verison info
- `-p file/path` to pass in your previously saved fortunes
- `-n Your Name` to let Cassandra know your name

## Gem dependencies

gem "httparty", "~> 0.18.1"

gem "rspec", "~> 3.10"

gem "ruby-progressbar", "~> 1.10"

gem "terminal-table", "~> 2.0"

gem "artii", "~> 2.1"

gem "tty-markdown", "~> 0.7.0"

gem "tty-prompt", "~> 0.23.0"

gem "tty-box", "~> 0.6.0"

gem "rainbow", "~> 3.0"

gem "tty-screen", "~> 0.8.1"

## API-s

- [Quotable](https://github.com/lukePeavey/quotable#get-random-quote)
- [Pipl](https://pipl.ir/)

## ASCII art

Ascii art  was sourced on: https://ascii.co.uk/art/fortune , the characters 'smd' were kept in is as a credit to the author.

## Purpose and scope - need to write more
300-500 words

This application is a fortune teller that can give user a prediction, tell them who they were in previous life, as well as create, read, delete and write into a fortunes log for their further reference.

This app is created solely for intertainment, so it can help people be intertained when they are in need of it. Or, if they are a believer in fortune tellers and predictions, it can help them receive some meaningful guidance. After all, one can argue that nothing that comes to our life is really random, including fortunes from a little terminal app.

The target audience for this app is people with some coding skills, that are confident with using the command line and can handle the installation process. They are also the people that like to be entertained, or in need of an advice for their life's desicions. Whenever they are bored or procrastinating, or need to make a hard desicion in life, or feel like nothing makes sense, they can open their terminal, run Cassandra.rb and receive some great fortunes to keep them going.

## Features

### Accepts four command line arguments

Cassandra has following features:

**"What my future holds"**

This is one of the main menu options, the user chooses it with an input. The menu is formatted with tty-prompt, so they select it with arrows on a keyboard and the "enter" key. Then, the programme displays a progress bar (made with ruby-progressbar gem), clears screen and displays a formatted string containing the fortune. The string is formatted with tty-box, as well as the rainbow gem. The strings are sourced from the Quotable API, they are random quotes from famous people, minus the name of the author. This is handled by the `FortuneTeller` class and a method `tell_fortune`. After the user gets their fortune, they can save it in their fortunes log, or get another one.

**"Who was I in previous life"**

This is another main menu option. It works similarly with telling fortunes, but gets data from differrent API - Pipl, a fake people generator. The response from the API comes in a form of a hash of hashes with all sorts of data, from first and last name to social security number, phone number, insurance etc. I have selected only some of the keys that can be valid for current app, like name, some physical data, birthplace, etc. I have changed some keys names to make more sence with the app. This feature is handled by it's own class `PreviousLife` and `FortuneTeller` class that uses a method from `PreviousLife`.


**Log file handling**

When the user have received their fortunes or previous life readings, they are prompted to save them in their fortunes log. If they don't have t yet, the programme detects it and creates one. The writing to the file happens after every fortune is displayed, when the user says that they want to save it. After outputting fortunes, the programme also adds them to current session's fortunes list. If the user wants to quit, they are asked if they want to keep or delete the log. If they choose to keep it, the programme shows the file path to it.

**Some other features include:**

- Menu displaying options
- Display user's fortunes just for the current session
- Display all fortunes from the log
- Display goodbye message
- Display greeting message
- Handles Standard error and Validation Error
- Handles command line arguments
- With -h argument, parses the README file in customized colour scheme
- Responsive: changes the ascii header font and adds/removes ascii image depending on a width of a terminal screen.