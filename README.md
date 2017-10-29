# instabot.rb

A instagram bot works without instagram api, only needs your username and password. writted with ruby.


if you like it just... hit the star button to make me happy! (≖ᴗ≖✿)
 
![#](https://img.shields.io/badge/status-complete-ff69b4.svg?style=for-the-badge)
![https://rubygems.org/gems/instabot](https://img.shields.io/badge/gem%20version-0.1.3-brightgreen.svg?style=for-the-badge)

## installation

install gem in command line via this command:  

```
    $ gem install instabot --no-ri --no-rdoc
```


## Usage

here is the **manual** usage and example:

```ruby
require 'instabot' 

Config.setup do |set|
    set.username                = 'replace_your_username'
    set.password                = 'replace_your_password'
end

bot = Instabot.new

bot.follow(11111111) # user id
bot.unfollow(11111111) # user id
bot.like(1111111) # media id
bot.comment(1111111, "comment text here") # media id
```

here is the **automatic** usage and example:

```ruby
require 'instabot' 

Config.setup do |set|
    set.username                = 'username'
    set.password                = 'password'
    set.tags                    = ["test","hello","birthday"]
    set.wait_per_action         = 1 * 3
    set.max_like_per_day        = 50
    set.max_follow_per_day      = 50
    set.max_unfollow_per_day    = 50
    set.max_comment_per_day     = 50
    set.pretty_print 	        = true
    set.infinite_tags           = true
    set.pre_load                = false
    set.comments                = [	
		["this", "the", "your"],
		["photo", "picture", "pic", "shot", "snapshot"],
		["is", "looks", "feels", "is really"],
		["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
		[".", "..", "...", "!","!!","!!!"]
	]
end

bot = Instabot.new
bot.mode(:infinite) # => Available modes: :infinite, :clean_up
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
infinite_tags | grab new tags by medias__(infinite tag grabber)__ | ```ture``` or ```false```
pretty_print | pretty and colorful output | true or false
pre_load | it will load pre configurations in **logs** folder | ```followed_users.txt```, ```unfollowed_users.txt```, ```liked_medias.txt```, ```commented_medias.txt```
comments | the comments you want to post in medias | just change the values in example



## Development description

Current available **modes** ```:infinite``` ```:clean_up```

**:infinite** it will make a infinite loop

**:clean_up** it will unfollow all the followed users

```ruby
get_user_informations(user_id) 
# it will return an object => @informations [ :followers, :following, :is_private, :is_verified, :username, :full_name, :full_name, :id]
get_media_informations(media_id) 
# it will return an object => @informations [ :text, :requested_by_viewer, :is_verified, :is_private, :full_name, :followed_by_viewer, :has_blocked_viewer, :viewer_has_liked, :comments_disabled, :is_video, :id]
search(["tags"]) 
# => Grabbing users and medias by tags (input should be an array)
check_login_status() 
# => Checking login status it will return (true or false)  
check_login_status(:auto_retry) # => also it has a auto retry ability
generate_a_comment() 
# => return a random string object (comment)
logout # => logging out from current account
get_page('page_url') 
# => exploring the page with current cookies and session

# Any another methods are available on rubydoc
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eVanilla/instabot.rb

## Used gems

* Activesupport
* Colorize
* Mechanize
* hashie


## What's new in the future ?

No idea...
