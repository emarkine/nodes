# Nodes
I do not like writing documentation. It takes my time which I could spend on programming.
If I do not need to report to anyone about a project, I usually delete the doc directory and forget about the text.
After all I'm a programmer and not a writer!
But recently I began to like to write texts.
And I loved this thing and restored the doc folder even in my old projects.
I want to share with other programmers about how writing texts can be not only necessary but also a pleasant experience.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nodes'
```

And then execute:
```bash
$ bundle
$ rails nodes:install:migrations
```
Add to you config/routes
```ruby
mount Nodes::Engine => '/nodes'
```


Or install it yourself as:
```bash
$ gem install nodes
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
