Dir.glob("#{Dir.pwd}/lib/*.rb").each {|file| require_relative file}
%w[colorize fileutils io/console mechanize hashie json logger pp].each {|gem| require gem} 

class Instabot

	include Config
	include Banner
	include Login
	include Actions
	include Protocol
	include Log
	include Grabber

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
			:white_list_users		=>		Config.options.white_list_users
			# :medias 				=> 		[],
			# :users 					=>		[]
		}
	end

	def initialize
		@users 		= []
		@medias 		= []
		@log_counter	= 1
		@login_status	= false
		@lib_dir	= "#{Dir.pwd}/lib"
		@root_dir		= "#{Dir.pwd}"
		@logs_dir		= "#@root_dir/logs"
		# print_banner
		create_mechanic
		login

	end


end
