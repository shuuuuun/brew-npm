# brew-npm

`brew npm` allows you to install any npm packages as a homebrew formula.

This project was forked from [sportngin/brew-gem](https://github.com/sportngin/brew-gem) and modified for npm.


## Installation

<!-- Via Rubygems:

    gem install brew-npm
    brew-npm install brew-npm -->

Via Homebrew:

    brew install shuuuuun/tap/brew-npm


## Usage

    brew npm install ${NPM_PACKAGE_NAME}

To install a specific version:

    brew npm install ${NPM_PACKAGE_NAME} ${VERSION}

To upgrade:

    brew npm upgrade ${NPM_PACKAGE_NAME}

To uninstall:

    brew npm uninstall ${NPM_PACKAGE_NAME}

To check information:

    brew npm info ${NPM_PACKAGE_NAME}

Note:

Installed packages are listed in `brew list` with prefix of `npm-`.


## Philosophy

This is not for installing development libraries, but for standalone binary tools that you want system wide.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shuuuuun/brew-npm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/shuuuuun/brew-npm/blob/master/CODE_OF_CONDUCT.md).


## Development

- `bin/setup` to install dependencies.
- `bin/console` for an interactive prompt that will allow you to experiment.
- `exe/brew-npm` to exec CLI locally.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the Brew::Npm project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/shuuuuun/brew-npm/blob/master/CODE_OF_CONDUCT.md).
