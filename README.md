<img src="./banner.png">

# instabot.rb

An ruby instagram bot and scrapper works without instagram api, only needs your username and password.

![https://rubygems.org/gems/instabot](https://img.shields.io/gem/dt/instabot.svg?label=DOWNLOADS&style=for-the-badge) 
![https://rubygems.org/gems/instabot](https://img.shields.io/gem/v/instabot.svg?label=GEM&style=for-the-badge)
![https://travis-ci.org/eVanilla/instabot.rb](https://img.shields.io/travis/eVanilla/instabot.rb.svg?label=BUILD&style=for-the-badge)

## installation

Add this to your __Gemfile__:
```
gem 'instabot'
```
and then execute
```
$ bundle install
```

or install it yourself as
```
$ gem install instabot --no-ri --no-rdoc
```

## Usage

here is the **basic** usage:

```ruby
require 'instabot' 

bot = Instabot.new :manual
bot.login("username","password")

bot.follow('user_id')
bot.unfollow('user_id')
bot.like('media_id')
bot.unlike('media_id')
bot.comment('media_id', 'comment text here')

bot.logout()
```

and here is the **automatic** usage:

```ruby
require 'instabot'

Config.setup do |set|
  set.username             = 'username'
  set.password             = 'password'
  set.tags                 = %w[test hello birthday]
  
  # set.use_proxy            = true # => it's important to enable the proxy usage
  # set.proxy                = ["localhost",8888] # without username and password
  # set.proxy                = ["localhost",8000,"USERNAME","PASSWORD"] # with username and password
  
  # set.use_tor              = true # default is false

  set.wait_per_action      = 5 * 60
  set.max_like_per_day     = 50
  set.max_follow_per_day   = 50
  set.max_unfollow_per_day = 50
  set.max_comment_per_day  = 50
  set.log_status           = true
  set.infinite_tags        = true
  set.add_tag_per_post     = 5
  set.print_banner         = true
  set.pre_load             = false

  set.unwanted_list        = ["_id","free_","free"]
  set.white_list_users     = ["john","alex","nick"]

  set.comments             = [
    %w[this the your],
    %w[photo picture pic shot snapshot],
    %w[is looks feels is really],
    %w[great super good very good good wow WOW cool GREAT magnificent magical very cool stylish beautiful so beautiful so stylish so professional lovely so lovely very lovely glorious so glorious very glorious adorable excellent amazing],
    %w[. .. ... ! !! !!!]
  ]
end

bot = Instabot.new
bot.mode(:infinite) # => :cleanup, :infinite, ...
```
> Note: Example files are [here](https://github.com/eVanilla/instabot.rb/tree/master/examples) 
> and be careful about using ```infinite_tags``` option

## Using proxies

```ruby
set.use_proxy                 = true # => it's so important to enable the proxy usage
set.proxy                     = ["localhost",8888] # without username and password
set.proxy                     = ["localhost",8000,"USERNAME","PASSWORD"] # with username and password
``` 
**don't have money to buy a proxy? no problem! continue reading**


## Using tor

first of all you have to download the latest ```tor expert bundle``` from [here](https://www.torproject.org/download/download.html.en)

then navigate to the ```Tor``` folder and run the ```tor --controlport 9051``` 

also don't forget to enable using tor by ```set.use_tor = true``` option, and that's it! we're done


## Configuration description: 

set | description | value __(example)__
------------ | ------------- | -------------
username | this is your IG username | ```your_ig_username```
password | this is your IG password | ```your_ig_password```
tags | This script use tags for searching medias & users | write whatever you want like this ```["hello_world", "test"]``` in an **array**
wait_per_action | wait time per actions  | ```1 * 60```
log_status | printing logs in the file | ```true``` or ```false```
unwanted_list | unwanted names in usernames | ```["_id","free_","free"]```
white_list_users | white list usernames | ```["john","alex","nick"]```
max_like_per_day | this is the max likes per day limitation | ```100```
max_follow_per_day | this is the max follows per day limitation | ```100```
max_unfollow_per_day | this is the max unfollows per day limitation | ```100```
max_comment_per_day | this is the max comments per day limitation | ```100```
infinite_tags | grab new tags by medias __(infinite tag grabber)__ | ```ture``` or ```false```
add_tag_per_post | an limit for ```infinite_tags```  | ```5``` , default is ```1```
print_banner | enable or disable banner | ```true``` or ```false```
comments | the comments you want to post in medias | just change the values in example
pre_load | load pre configurations in **logs** folder | ```followed_users.txt```, ```unfollowed_users.txt```, ```liked_medias.txt```, ```commented_medias.txt```
use_tor | enabling and disabling the tor usage | ```true``` or ```false```
use_proxy | enabling and disabling the proxy usage | ```true``` or ```false```
proxy | http(s) proxy details | write it in an array like this ```["IP",PORT]``` or if it has username and password you have to use this format ```["IP",PORT,"USERNAME","PASSWORD"]``` 

**Development description:**
> Methods are available on rubydoc.



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eVanilla/instabot.rb

Also thank you guys! [Contributors](https://github.com/eVanilla/instabot.rb/graphs/contributors)

and if you like it just... hit the star button to make me __(us)__ happy! (≖ᴗ≖✿)
 
## Used gems

* Activesupport
* Mechanize
* Colorize
* hashie
* socksify
* net-telnet

## What's new in the future ?

Still no idea... what do you think?
