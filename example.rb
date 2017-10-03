<<<<<<< HEAD
require_relative './instabot.rb' 
=======

require_relative './core' 
>>>>>>> 3a336748b35424648b0da87abea050a9c8c883b1

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

<<<<<<< HEAD
bot.follow(53703081)	
bot.unfollow(53703081)
bot.like(537030812)
bot.comment(537030812, "test comment")
=======
bot.follow(00000000)
bot.unfollow(00000000)
bot.like(00000000)
bot.comment(00000000,"test comment")
>>>>>>> 3a336748b35424648b0da87abea050a9c8c883b1
