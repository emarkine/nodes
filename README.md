# Nodes
Short description and motivation.

## Usage
To work with single model use the following tasks.

Dump rails model Name into file spec/fixtures/names.yml  
```bash
$ rails db:model:dump[name]
```
Load from file spec/fixtures/names.yml to model Name 
```bash
$ rails db:model:load[name]
```
Migrate model Name down 
```bash
$ rails db:model:down[name]
```
Migrate model Name up 
```bash
$ rails db:model:up[name]
```
Migrate down and then up 
```bash
$ rails db:model:redo[name]
```
Reset model: dump, migrate down, then up and load 
```bash
$ rails db:model:reset[name]
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nodes'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install nodes
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
