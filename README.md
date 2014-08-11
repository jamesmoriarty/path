# Path

TODO: Write a gem description

## Usage

```ruby
require "path"

nodes = [
  [true,  false, true],
  [true,  true,  true],
  [false, false, true]
].to_nodes
# => [[<#Node>, ...][...][...]]

to   = nodes[2][2]
from = nodes[0][0]

heuristic = lambda do |to, from|
  x = to.data[:x] - from.data[:x]
  y = to.data[:y] - from.data[:y]

  Math.sqrt(x ** 2 + y ** 2)
end

distances = Path::Node.df_search from, to, heuristic
# => { <#Node> => <distance>, ... }

while(from != to) do
  from = from.neighbors.min do |a, b|
    a = distances[a] || Float::INFINITY
    b = distances[b] || Float::INFINITY
    a <=> b
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'path'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install path

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/path/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
