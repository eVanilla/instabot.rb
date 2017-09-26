require_relative 'modules'
require 'pp'
class Instabot
	# => Configuration
	include Config
	def options
		return {
			:username 				=> 		Config.options.username,
			:password 				=>		Config.options.password,
			:max_likes_per_day 		=> 		Config.options.max_likes_per_day,
			:max_follow_per_day 	=> 		Config.options.max_follow_per_day,
			:max_comments_per_day	=> 		Config.options.max_comments_per_day,
			:unwanted_list 			=> 		Config.options.unwanted_list,
			:white_list_users 		=> 		Config.options.white_list_users	
		}
	end


end