Dir.glob("#{Dir.pwd}/lib/*.rb").each {|file| require_relative file}
%w[colorize mechanize io/console hashie json logger pp active_support/core_ext/numeric/time rbconfig].each {|gem| require gem} 

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

	def initialize

		@users 					= []
		@medias 				= []
		@log_counter			= 0
		@login_status			= false
		@lib_dir				= "#{Dir.pwd}/lib"
		@root_dir				= "#{Dir.pwd}"
		@logs_dir				= "#@root_dir/logs"

		@local_stroage 			= {
			:followed_users 	=> [],
			:unfollowed_users 	=> [],
			:liked_medias 		=> [],
			:commented_medias 	=> []
		}  

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

		# pp "maximums: #{@maximums}"
		# @os ||= (
		# 	host_os = RbConfig::CONFIG['host_os']
		# 	case host_os
		# 	when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
		# 		:windows
		# 	when /darwin|mac os/
		# 		:macosx
		# 	when /linux/
		# 		:linux
		# 	when /solaris|bsd/
		# 		:unix
		# 	else
		# 		raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
		# 	end
		# )


		intro
		


	end


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
			:comments  				=> 		Config.options.comments,
			:pre_load  				=> 		Config.options.pre_load,
			:pretty_print			=> 		Config.options.pretty_print
			# :medias 				=> 		[],
			# :users 				=>		[]
		}
	end

	def custom_puts(text="")
		pretty_print_mode = options[:pretty_print]
		if pretty_print_mode
			puts "#{text}"
		else
			puts "#{text}".colorize(color: :white, background: :default)
		end
	end
	
	def custom_print(text="")
		pretty_print_mode = options[:pretty_print]
		empty_space =  IO.console.winsize[1] - text.size
		empty_space = 0 if empty_space < 0 
		if pretty_print_mode
			print "\r#{text}"
			$stdout.flush
			print  " " * empty_space
			# IO.console.flush
		else
			print "#{text}\n".white
		end
	end



	def intro
		trap("INT") { exit! }
		print_banner
		check_log_files
		create_mechanic
		custom_print "[+] ".cyan + "Processing successfully completed"
		puts
		login

	end


end
