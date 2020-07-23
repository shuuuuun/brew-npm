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

    brew npm install koko

To install a specific version:

    brew npm install koko 0.6.0

To upgrade:

    brew npm upgrade koko

To uninstall:

    brew npm uninstall koko

To check information:

    brew npm info koko

Note:

Installed packages are listed in `brew list` with prefix of `npm-`, like `npm-koko`.


## Philosophy

This is **not** for installing development libraries, but for standalone binary tools that you want system wide.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shuuuuun/brew-npm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/shuuuuun/brew-npm/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the Brew::Npm project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/shuuuuun/brew-npm/blob/master/CODE_OF_CONDUCT.md).
