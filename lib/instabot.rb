Dir.glob("#{Dir.pwd}/lib/*.rb").each {|file| require_relative file}
%w[colorize fileutils io/console mechanize hashie json logger pp].each {|gem| require gem} 

class Instabot

	include Automodes
	include Actions
	include Banner
	include Config
	include Grabber
	include Login
	include Log
	include Protocol

	attr_accessor :users, :medias

	def options
		return {
			:username				=>		Config.options.username,
			:password				=>		Config.options.password,
			:tags					=>		Config.options.tags,
			:max_likes_per_day		=>		Config.options.max_likes_per_day,
			:max_follow_per_day		=>		Config.options.max_follow_per_day,
			:max_comments_per_day	=>		Config.options.max_comments_per_day,
			:unwanted_list			=>		Config.options.unwanted_list,
			:white_list_users		=>		Config.options.white_list_users,
			:wait_per_action		=> 		Config.options.wait_per_action
			# :medias 				=> 		[],
			# :users 				=>		[]
		}
	end

	def initialize

		@users 					= []
		@medias 				= []
		@log_counter			= 1
		@login_status			= false
		@lib_dir				= "#{Dir.pwd}/lib"
		@root_dir				= "#{Dir.pwd}"
		@logs_dir				= "#@root_dir/logs"


		@likes_in_day 			= 0
		@follows_in_day 		= 0
		@unfollows_in_day 		= 0
		@comments_in_day 		= 0

		@max_likes_per_day 		= options[:max_likes_per_day]
		@max_follow_per_day 	= options[:max_follow_per_day]
		@max_unfollow_per_day 	= options[:max_unfollow_per_day]
		@max_comment_per_day 	= options[:max_comment_per_day]


		##########[METHODS]##########
		check_log_file
		# print_banner
		create_mechanic
		login
		##########[METHODS]##########

	end


end
