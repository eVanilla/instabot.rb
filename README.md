# instabot.rb
A instagram bot works without instagram api, only needs your username and password. writted on ruby

![#](https://img.shields.io/badge/status-under%20construction-ff69b4.svg)

# Usage
here is the simple usage or example:

```ruby
require_relative './lib/instabot' 

Config.setup do |set|
    set.username                = 'username'
    set.password                = 'password'
    set.tags                    = ["test","hello","birthday"]
end

bot = Instabot.new

bot.follow(53703081)
bot.unfollow(53703081)
bot.like(537030812)
bot.comment(537030812, "test comment")
```

# What's new in the future ?

fully automatic actions
&...

