Dir.glob("#{Dir.pwd}/lib/*.rb").each {|file| require_relative file}
%w[colorize fileutils io/console mechanize hashie json logger pp].each {|gem| require gem} 

class Instabot

	include Modes
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
			:max_like_per_day		=>		Config.options.max_like_per_day,
			:max_follow_per_day		=>		Config.options.max_follow_per_day,
			:max_unfollow_per_day	=>		Config.options.max_unfollow_per_day,
			:max_comment_per_day	=>		Config.options.max_comment_per_day,
			:unwanted_list			=>		Config.options.unwanted_list,
			:white_list_users		=>		Config.options.white_list_users,
			:wait_per_action		=> 		Config.options.wait_per_action,
			:comments  				=> 		Config.options.comments
			# :medias 				=> 		[],
			# :users 				=>		[]
		}
	end

	def initialize

		@users 					= []
		@medias 				= []
		@log_counter			= 0
		@login_status			= false
		@lib_dir				= "#{Dir.pwd}/lib"
		@root_dir				= "#{Dir.pwd}"
		@logs_dir				= "#@root_dir/logs"



		@maximums = {
			:follows_in_day	 		=> 0,
			:unfollows_in_day 		=> 0,
			:likes_in_day 			=> 0,
			:comments_in_day 		=> 0,

			:max_follows_per_day 	=> options[:max_follow_per_day],
			:max_unfollows_per_day 	=> options[:max_unfollow_per_day],
			:max_likes_per_day		=> options[:max_like_per_day],
			:max_comments_per_day 	=> options[:max_comment_per_day]
		}

		pp "maximums: #{@maximums}"

		# @likes_in_day 			= 0
		# @follows_in_day 		= 0
		# @unfollows_in_day 		= 0
		# @comments_in_day 		= 0
		# @max_likes_per_day 		= options[:max_like_per_day]
		# @max_follows_per_day 	= options[:max_follow_per_day]
		# @max_unfollows_per_day 	= options[:max_unfollow_per_day]
		# @max_comments_per_day 	= options[:max_comment_per_day]

		##########[METHODS]##########
		
		# print_banner
		check_log_file
		create_mechanic
		login

	end


end
