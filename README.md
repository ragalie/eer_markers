# EerMarkers

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/eer_markers`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eer_markers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eer_markers

## Usage

Copy the config/v1.yml.sample file to config/v1.yml. Then add and remove the row numbers that you want to keep in the v1 output. For instance, if you want to keep rows 1 and 2 (zero-indexed), you would have a YAML file like this:

```yaml
rows:
- 1
- 2
```

Put your original files in the orig folder in this repository. Then run:

    $ find orig -name '*.m' -exec bundle exec bin/eer_markers1 {} \;

When that completes, you'll see your v1 files in the v1 directory. You can then run:

    $ find v1 -name '*.m' -exec bundle exec bin/eer_markers2 {} \;

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/eer_markers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
