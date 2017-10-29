require 'instabot' 

Config.setup do |set|
	set.username                = 'replace_your_username'
	set.password                = 'replace_your_password'
	set.tags                    = ["test","hello","birthday"]
	set.wait_per_action         = 1 * 60

	set.max_like_per_day       	= 6
	set.max_follow_per_day      = 6
	set.max_unfollow_per_day    = 6
	set.max_comment_per_day    	= 6

	set.comments                = [	
									["this", "the", "your"],
									["photo", "picture", "pic", "shot", "snapshot"],
									["is", "looks", "feels", "is really"],
									["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
									[".", "..", "...", "!","!!","!!!"]
								]
	set.pretty_print 			= true
	set.pre_load 				= false
	set.infinite_tags 			= true


	# set.unwanted_list         = ["_id","free_","free"] # => under construction ...
	# set.white_list_users      = ["john","alex","nick"] # => under construction ...
end


bot = Instabot.new
bot.mode(:infinite) # => :cleanup, ...



# => manual methods 

# bot.follow("user_id")  
# bot.unfollow("user_id")
# bot.like("media_id")
# bot.comment("media_id", "test comment")
