<<<<<<< HEAD
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


bot.follow(53703081)
bot.unfollow(53703081)
bot.like(537030812)
bot.comment(537030812,"test comment")
=======
require_relative 'core' 

Config.setup do |config|
  config.username 				      = 'evoke'
  config.password 				      = '1234567'
  config.max_likes_per_day 		  = '5'
  config.max_follow_per_day 	  = '5'
  config.max_comments_per_day 	= '5'
  config.unwanted_list 			    = ["_id","free_","free"]
  config.white_list_users 		  = ["john","alex","nick"]
end

instagram = Instabot.new
puts instagram.options
>>>>>>> a051dbe24e5085975c69b8ac6d0b8688aa63eafb
