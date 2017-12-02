module Config

	class << self
		attr_accessor :options
	end

	def self.setup
		self.options ||= Configuration.new
		yield(options)
	end

	class Configuration
		attr_accessor :username, :password, :tags, :use_proxy, :proxy, :comments, :print_banner, :pre_load, :wait_per_action, :infinite_tags, :max_like_per_day, :max_follow_per_day, :max_unfollow_per_day, :max_comment_per_day, :unwanted_list, :white_list_users#, :print_logs
		def initialize
			@username				= nil
			@password 				= nil
			@white_list_users 		= nil
			@unwanted_list 			= nil
			@wait_per_action		= 1 * 60
			@tags					= ["test","hello","hello_world","birthday","food"]
			@max_like_per_day 		= 50
			@max_follow_per_day 	= 50
			@max_unfollow_per_day	= 50
			@max_comment_per_day	= 50
			@comments 				= [	
										["this", "the", "your"],
										["photo", "picture", "pic", "shot", "snapshot"],
										["is", "looks", "feels", "is really"],
										["great", "super", "good", "very good", "good","wow", "WOW", "cool", "GREAT","magnificent","magical", "very cool", "stylish", "beautiful","so beautiful", "so stylish","so professional","lovely", "so lovely","very lovely", "glorious","so glorious","very glorious", "adorable", "excellent","amazing"], 
										[".", "..", "...", "!","!!","!!!"]
									]	
			@use_proxy 				= false
			@proxy 					= []
			@infinite_tags 			= true
			@pre_load 				= true
			@print_banner 			= true
			# @pretty_print 			= true
			# @print_logs 			= true
		end	
	end

end