require_relative './lib/instabot' 

Config.setup do |set|
	set.username                = 'eyuji_.4'
	set.password                = 'programmer'
	set.tags                    = ["test","hello","birthday"]
	set.wait_per_action         = 1 * 30

	set.max_like_per_day       	= 0
	set.max_follow_per_day      = 0
	set.max_unfollow_per_day    = 0
	set.max_comment_per_day    	= 0

	set.comments                = [	
									["this", "the", "your"],
									["photo", "picture", "pic", "shot", "snapshot"],
									["is", "looks", "feels", "is really"],
									["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
									[".", "..", "...", "!","!!","!!!"]
								]
	# set.unwanted_list         = ["_id","free_","free"]
	# set.white_list_users      = ["john","alex","nick"]
end


bot = Instabot.new
bot.mode(:auto) # => :auto, :cleanup, ...

# bot.follow(53703081)  
# bot.unfollow(53703081)
# bot.like(1619537506763936725)
# bot.comment(537030812, "test comment")