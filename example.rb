
require_relative './core' 

Config.setup do |set|
	set.username 				= 'username'
	set.password 				= 'password'
	set.max_likes_per_day 		= '5'
	set.max_follow_per_day 		= '5'
	set.max_comments_per_day 	= '5'
	set.unwanted_list 			= ["_id","free_","free"]
	set.white_list_users 		= ["john","alex","nick"]
end

bot = Instabot.new


bot.follow(00000000)
bot.unfollow(00000000)
bot.like(00000000)
bot.comment(00000000,"test comment")
