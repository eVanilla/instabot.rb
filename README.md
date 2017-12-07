![https://github.com/eVanilla/instabot.rb](https://raw.githubusercontent.com/eVanilla/instabot.rb/master/BANNER.PNG)

# instabot.rb

An instagram bot works without instagram api, only needs your username and password. written in ruby.

![https://rubygems.org/gems/instabot](https://img.shields.io/gem/dt/instabot.svg?label=DOWNLOADS&style=for-the-badge) 
![https://rubygems.org/gems/instabot](https://img.shields.io/gem/v/instabot.svg?label=GEM&style=for-the-badge)
![https://travis-ci.org/eVanilla/instabot.rb](https://img.shields.io/travis/eVanilla/instabot.rb.svg?label=BUILD&style=for-the-badge)

## installation

Add this to your __Gemfile__:
```
gem 'instabot'
```
and make sure you run this ```bundle install``` command

or install it for yourself as
```
$ gem install instabot --no-ri --no-rdoc
```

## Usage

here is the **manual** usage:

```ruby
require 'instabot' 
bot = Instabot.new :manual # => Available modes => :manual, :default => default mode is :default 

bot.login("username","password") # => manual login

bot.follow(11111111) # user id
bot.unfollow(11111111) # user id
bot.like(1111111) # media id
bot.unlike(1111111) # media id
bot.comment(1111111, "comment text here") # media id

bot.logout() # => logout from current account
```

and here is the **automatic** usage:

```ruby
require 'instabot' 

Config.setup do |set|
    set.username                = 'replace_your_username'
    set.password                = 'replace_your_password'
    set.tags                    = ["test","hello","birthday"]
    set.wait_per_action         = 1 * 60 # => second
    set.max_like_per_day        = 50
    set.max_follow_per_day      = 50
    set.max_unfollow_per_day    = 50
    set.max_comment_per_day     = 50
    set.infinite_tags           = true
    set.print_banner            = true
    set.pre_load                = false
    set.comments                = [ 
        ["this", "the", "your"],
        ["photo", "picture", "pic", "shot", "snapshot"],
        ["is", "looks", "feels", "is really"],
        ["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
        [".", "..", "...", "!","!!","!!!"]
    ]
end

bot = Instabot.new # => Available modes => :manual, :default => default mode is :default 
bot.mode(:infinite) # => Available modes => :infinite, :clean_up
```
> Note: be careful about using ```infinite_tags``` option

## Using proxies

```ruby
set.use_proxy                 = true # => it's so important to enable the proxy usage
set.proxy                     = ["localhost",8888] # without username and password
set.proxy                     = ["localhost",8000,"USERNAME","PASSWORD"] # with username and password
``` 

## Configuration description: 

set | description | value __(example)__
------------ | ------------- | -------------
username | this is your IG username | ```replace_your_username```
password | this is your IG password | ```replace_your_password```
tags | This script use tags for searching medias | write whatever you want like this ```["hello_world", "test"]``` in an **array** form
wait_per_action | if you want to use automatic mode so then you have to use this, because you will be banned from IG | ```1 * 60```
max_like_per_day | this is the max likes per day limitation | ```100```
max_follow_per_day | this is the max follows per day limitation | ```100```
max_unfollow_per_day | this is the max unfollows per day limitation | ```100```
max_comment_per_day | this is the max comments per day limitation | ```100```
infinite_tags | grab new tags by medias __(infinite tag grabber)__ | ```ture``` or ```false```
print_banner | enable or disable banner | ```true``` or ```false```
comments | the comments you want to post in medias | just change the values in example
pre_load | load pre configurations in **logs** folder | ```followed_users.txt```, ```unfollowed_users.txt```, ```liked_medias.txt```, ```commented_medias.txt```
use_proxy | enabling and disabling the proxy usage | ```true``` or ```false```
proxy | http(s) proxy details | write it on an array form like this ```["IP",PORT]``` or if it has username and password you have to use this format ```["IP",PORT,"USERNAME","PASSWORD"]``` 

**Development description:**

> Methods are available on rubydoc.



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eVanilla/instabot.rb

Also i have to say thank you for all you guys who contributed on this project

and if you like it just... hit the star button to make me __(us)__ happy! (≖ᴗ≖✿)
 
## Used gems

* Activesupport
* Colorize
* Mechanize
* hashie

## What's new in the future ?

Still no idea... what do you think?
