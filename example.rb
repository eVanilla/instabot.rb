require_relative './instabot.rb' 

Config.setup do |set|
	set.username				= 'username'
	set.password				= 'password'
	set.max_likes_per_day		= '5'
	set.max_follow_per_day		= '5'
	set.max_comments_per_day	= '5'
	set.unwanted_list			= ["_id","free_","free"]
	set.white_list_users		= ["john","alex","nick"]
end

bot = Instabot.new

# bot.get_user_informations(53703081)

bot.follow(53703081)	
bot.unfollow(53703081)
bot.like(537030812)
bot.comment(537030812, "test comment")
