require_relative 'core' 

Config.setup do |config|
  config.username 				= 'evoke'
  config.password 				= '1234567'
  config.max_likes_per_day 		= '5'
  config.max_follow_per_day 	= '5'
  config.max_comments_per_day 	= '5'
  config.unwanted_list 			= ["_id","free_","free"]
  config.white_list_users 		= ["john","alex","nick"]
end

instagram = Instabot.new
puts instagram.options