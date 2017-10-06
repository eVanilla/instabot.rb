require_relative './lib/instabot' 

Config.setup do |set|
	set.username                = 'username'
	set.password                = 'password'
	set.tags                    = ["test","hello","birthday"]
	set.wait_per_action         = 1 * 60
	set.max_likes_per_day       = '5'
	set.max_follow_per_day      = '5'
	set.max_comments_per_day    = '5'
	# set.comments                = [	
	# 								["this", "the", "your"],
	# 								["photo", "picture", "pic", "shot", "snapshot"],
	# 								["is", "looks", "feels", "is really"],
	# 								["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
	# 								[".", "..", "...", "!","!!","!!!"]
	# 							]
	# set.unwanted_list         = ["_id","free_","free"]
	# set.white_list_users      = ["john","alex","nick"]
end


bot = Instabot.new

# bot.search(bot.options[:tags])
# bot.get_media_informations(bot.medias[0])
# bot.get_user_informations(53703081)
# bot.auto_mode
# bot.follow(53703081)  
# bot.unfollow(53703081)
# bot.like(1619537506763936725)
# bot.comment(537030812, "test comment")
