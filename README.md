# instabot.rb
A instagram bot works without instagram api, only needs your username and password. writted with ruby
if you like it ... just hit the star button to make me happy! (≖ᴗ≖✿)
 
![#](https://img.shields.io/badge/status-nearly%20complete-ff69b4.svg?style=for-the-badge)

# installation

clone the project via git command:
```
git clone https://github.com/eVanilla/instabot.rb.git
```

and make sure you installed the bundler gem and then type this command in project folder:
```
bundle install
```
> Bundler will download and install all the dependencies and gems

# Usage
here is the **manual** usage or example:

```ruby
require_relative './lib/instabot' 

Config.setup do |set|
    set.username                = 'replace_your_username'
    set.password                = 'replace_your_password'
end

bot = Instabot.new

bot.follow(11111111) # user id
bot.unfollow(11111111) # user id
bot.like(1111111) # media id
bot.comment(1111111, "test comment") # media id
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
