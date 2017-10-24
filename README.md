# instabot.rb
A instagram bot works without instagram api, only needs your username and password. writted with ruby
if you like it ... just hit the star button to make me happy! (◕‿◕✿)

![#](https://img.shields.io/badge/status-under%20construction-ff69b4.svg)

# installation

clone the project via git command:
```
git clone https://github.com/eVanilla/instabot.rb.git
```

and make sure you installed the bundler gem and then type this command in project folder:
```
bundle install
```
> Bundler will download and install all the dependencies and gems i used

# Usage
here is the **manual** usage or example:

```ruby
require_relative './lib/instabot' 

Config.setup do |set|
    set.username                = 'replace_your_username'
    set.password                = 'replace_your_password'
    set.tags                    = ["test","hello","birthday"]
end

bot = Instabot.new

bot.follow(53703081)
bot.unfollow(53703081)
bot.like(537030812)
bot.comment(537030812, "test comment")
```

if you want to make it **automaticly**, here is the example:

```ruby
require_relative './lib/instabot' 

Config.setup do |set|
    set.username                = 'username'
    set.password                = 'password'
    set.tags                    = ["test","hello","birthday"]
end

bot = Instabot.new
bot.mode(:auto)
```

# What's new in the future ?
no idea
