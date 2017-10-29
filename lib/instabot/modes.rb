module Modes

	def mode(mode=:default)
		case mode
		when :infinite
			custom_print "[+] ".cyan + "Auto mode is turned on".yellow
			search(options[:tags])
			@next_day = Time.new + 1.days
			puts
			while true
				# if @maximums[:likes_in_day] != @maximums[:max_likes_per_day] && @maximums[:follows_in_day] != @maximums[:max_follows_per_day] && @maximums[:unfollows_in_day] != @maximums[:max_unfollows_per_day] &&  @maximums[:comments_in_day] != @maximums[:max_comments_per_day]	
				if !maximums_are_full?
					# custom_puts "[+] " + "".red
					if @maximums[:follows_in_day] != @maximums[:max_follows_per_day]
						@maximums[:follows_in_day] += 1
						auto_follow 
					else
						custom_puts "[+] ".cyan + "Maximum follows per day"
					end

					if @maximums[:unfollows_in_day] != @maximums[:max_unfollows_per_day]
						@maximums[:unfollows_in_day] += 1
						auto_unfollow
					else
						custom_puts "[+] ".cyan + "Maximum unfollows per day"
					end

					if @maximums[:likes_in_day] != @maximums[:max_likes_per_day]
						@maximums[:likes_in_day] += 1
						auto_like
					else
						custom_puts "[+] ".cyan + "Maximum likes per day"
					end

					if @maximums[:comments_in_day] != @maximums[:max_comments_per_day]
						@maximums[:comments_in_day] += 1
						auto_comment
					else
						custom_puts "[+] ".cyan + "Maximum comments per day"
					end
					# custom_print "maximums = #{@maximums}"
					
					# exit
				else
					# custom_print "in check date ... "
					check_date
					sleep 1
				end
			end
		when :cleanup
			custom_puts "[+] ".cyan + "Clean up mode is turned on"
			@local_stroage[:followed_users].each do |user|
				unfollow(user)
			end
			# users.each do |user|
			# 	get_user_informations(user)
			# 	unfollow(@informations[:id])
			# end
		when :default
			custom_print "[-] ".cyan + "Please choose a mode".red
		else
			custom_print "[-] ".cyan + "Please choose a mode".red
		end
	end










	def auto_follow
		all_users 	= users
		id 			= 0
		custom_puts "[+] ".cyan + "#{all_users.size} users ready to follow"
		# users.each do |user| 
		while @maximums[:follows_in_day] < @maximums[:max_follows_per_day]
			begin 
				id += 1 if all_users[id].nil? || all_users[id] == []
				get_user_informations(all_users[id])
				# custom_print "user informations:".cyan
				# @informations.map {|key,val| custom_print "#{key}: #{val}"}
				custom_puts "[+] ".cyan + "Trying to follow a user [#{all_users[id]}]"
				follow(@informations[:id])
				custom_puts "\n[+] ".cyan + "User followed!".green.bold
				@maximums[:follows_in_day] += 1
				id += 1
				# custom_print "development informations: ".cyan
				# custom_print "follows_in_day = #{@maximums[:follows_in_day]} || max_follows_per_day = #{@maximums[:max_follows_per_day]} || id = #{id}"
				fall_in_asleep
			rescue Exception => e
				puts "an error detected ... #{e} #{e.backtrace}\nignored"
				id += 1
				retry
			end
		end
		# end
	end

	def auto_unfollow
		# users.each do |user|
		followed_users = @local_stroage[:followed_users]
		custom_puts "[+] ".cyan + "#{followed_users.size} users ready to unfollow"
		id 			= 0
		while @maximums[:unfollows_in_day] < @maximums[:max_unfollows_per_day]
			if @local_stroage[:followed_users].size < @maximums[:max_unfollows_per_day]
			begin 
				# get_user_informations(unfollowed_users[id])
				# custom_print "user informations:".cyan
				# @informations.map {|key,val| custom_print "#{key}: #{val}"}
				# custom_print "unfollowed_users[id] => #{unfollowed_users[id]}"
				custom_puts "[+] ".cyan + "Trying to unfollow a user [#{followed_users[id]}]"	
				unfollow(followed_users[id])
				custom_puts "\n[+] ".cyan + "User unfollowed!".bold.green
				@maximums[:unfollows_in_day] += 1
				id += 1
				# custom_print "unfollows_in_day = #{@maximums[:unfollows_in_day]} || max_unfollows_per_day = #{@maximums[:max_unfollows_per_day]} || id = #{id}"
				fall_in_asleep
			rescue Exception => e
				puts "an error detected ... #{e}\nignored"
				id += 1
				retry
			end
			else
				custom_print "[+] ".cyan + "[unfollow users per day] is bigger than followed users"
				break
			end
		end
	end

	def auto_like
		# medias.each do |media|
		all_medias 	= medias
		custom_puts "[+] ".cyan + "#{all_medias.size} medias ready to like"
		id 			= 0
		while @maximums[:likes_in_day] < @maximums[:max_likes_per_day]
			begin 
				get_media_informations(all_medias[id])
				# custom_print "media informations:".cyan
				# @informations.map {|key,val| custom_print "#{key}: #{val}"}
				custom_puts "[+] ".cyan + "Trying to like a media[#{all_medias[id]}]"	
				like(@informations[:id])
				custom_puts "\n[+] ".cyan + "Media liked".green.bold
				@maximums[:likes_in_day] += 1
				# custom_print "likes_in_day = #{@maximums[:likes_in_day]} || max_likes_per_day = #{@maximums[:max_likes_per_day]}"
				id += 1
				fall_in_asleep
			rescue Exception => e
				puts "an error detected ... #{e}\n#{e.backtrace.inspect}\nignored"
				id += 1
				retry
			end
		end
	end

	def auto_comment
		# medias.each do |media|
		all_medias 	= medias
		custom_puts "[+] ".cyan + "#{all_medias.size} medias ready to send a comment"
		id 			= 0
		while @maximums[:comments_in_day] < @maximums[:max_comments_per_day]
			begin 
				get_media_informations(all_medias[id])
				# custom_print "media informations:".cyan
				# @informations.map {|key,val| custom_print "#{key}: #{val}"}
				custom_puts "[+] ".cyan + "Trying to send a comment to media[#{all_medias[id]}]"	
				comment(@informations[:id], generate_a_comment)
				custom_puts "\n[+] ".cyan + "comment successfully has been sent".green.bold
				@maximums[:comments_in_day] += 1
				# custom_print "comments_in_day = #{@maximums[:comments_in_day]} || max_comments_per_day = #{@maximums[:max_comments_per_day]}"
				id += 1
				fall_in_asleep
			rescue Exception => e
				puts "an error detected ... #{e}\n#{e.backtrace.inspect}\nignored"
				id += 1
				retry
			end
		end
	end
	
	def generate_a_comment
		comments 	= options[:comments]
		first 		= comments[0].sample
		second 		= comments[1].sample
		third 		= comments[2].sample
		fourth		= comments[3].sample
		fifth 		= comments[4].sample
		return "#{first} #{second} #{third} #{fourth}#{fifth}"
	end

	def check_date
		# custom_print "checking time ..."
		time = ((@next_day) - Time.new).to_i # => seconds elapsed ...
		# custom_print "next day = #{@next_day}"
		if time == 0

			custom_print "[+] ".cyan + "It's a new day"
			@local_stroage[:followed_users] 	= []
			@local_stroage[:unfollowed_users] 	= []
			@local_stroage[:liked_medias] 		= []
			@local_stroage[:commented_medias] 	= []
			@maximums[:follows_in_day] 			= 0 
			@maximums[:unfollows_in_day] 		= 0
			@maximums[:likes_in_day] 			= 0
			@maximums[:comments_in_day] 		= 0
			# time = (((Time.new + 1.days).to_f - Time.new.to_f) * 24 * 60 * 60).to_i
			@next_day = Time.new + 1.days
			# custom_print "new next day = #{@next_day}"
			# custom_print "new maximums = #{@maximums}"
			# custom_print "new local stroage = #{@local_stroage}"
			# custom_print "="*10
			unless @infinite_tags == true
				search(options[:tags])
			end

		else
			custom_print "[+] ".cyan + "#{time} seconds remained"
		end 
			# return true
	end

	def fall_in_asleep
		time = options[:wait_per_action]
		custom_puts "\n[+] ".cyan + "Waiting for #{time} seconds"
		sleep time
	end

	def maximums_are_full?
		if @maximums[:likes_in_day] == @maximums[:max_likes_per_day] && @maximums[:follows_in_day] == @maximums[:max_follows_per_day] && @maximums[:unfollows_in_day] == @maximums[:max_unfollows_per_day] && @maximums[:comments_in_day] == @maximums[:max_comments_per_day]
			return true
		else
			return false
		end
	end







end