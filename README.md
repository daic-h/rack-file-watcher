# Rack::FileWatcher

[![Build Status](https://travis-ci.org/daic-h/rack-file-watcher.svg?branch=master)](https://travis-ci.org/daic-h/rack-file-watcher)


Rack middleware to handle events on file modifications.

If you are using an application server of prefork type(unicorn, passenger), it is useful if you want to do a simple processing in the child process. (For example, clear the Rails.cache)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-file-watcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-file-watcher

## Usage

Basic configuring the middleware:

```ruby
require 'rack/file_watcher'

use Rack::FileWatcher, 'tmp/watch.txt' do
  puts 'updated.'
end

app = proc do |env|
  [ 200, {'Content-Type' => 'text/plain'}, 'Hello World' ]
end
run app
```

## Example

Example in Rails:

```ruby
# config/application.rb

module YourApp
  class Application < Rails::Application

    # ...

    config.middleware.use Rack::FileWatcher, config.root.join('tmp/clear_cache.txt') do
      Rails.cache.clear
    end
  end
end

```

## Contributing

1. Fork it ( https://github.com/daic-h/rack-file-watcher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) Daichi HIRATA, released under the MIT license.
