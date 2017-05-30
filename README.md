Warning: This gem is in active development and currently does absolutely nothing.

# ActiveScratcher
ActiveRecord-based gem to get you from 'git clone' to 'rails s'

## Installation
Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'activescratcher'
end
```

And then execute:
```bash
$ bundle install
```

## Usage
You have everything you need to work in a brand new project, you've bundle installed, run migrations and now it's time to spin up the project.

\* record scratch \*

![A Record Scratch](https://19818-presscdn-pagely.netdna-ssl.com/wp-content/uploads/934/35/ae736cf59a057c35818d955fbd3ab0b9.jpg)

\* freeze frame \*

Someone forgot to add seed data to your project. In effect, you now have to add and link models together.

Insert ActiveScratcher (because we scratch the sh*t out of ActiveRecord).

```ruby
# Start the rails console
rails c
```

```ruby
# Run ActiveScratcher with no parameter
ActiveScratcher::Scratch.execute()
```

```ruby
# Run ActiveScratcher with excluding certain tables
ActiveScratcher::Scratch.execute(exclusions:"Person,Address")
```

```ruby
# Run ActiveScratcher with a set amount of children for has_many relations
ActiveScratcher::Scratch.execute(children: 2)
```



## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
