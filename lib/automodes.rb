module Automodes




	def auto_mode
		# puts "in auto mode"
		# bot.search(bot.options[:tags])
		# while true
			# auto_liker
			# ...
		# end
	end










	def auto_follow
		users.each do |user| 
			follow(user)
		end
	end

	def auto_unfollow
		users.each do |user|
			unfollow(user)
		end
	end

	def auto_liker
		medias.each do |media|
			get_media_informations(media)
			puts "[like] id => #{@informations[:id]}"
			like(@informations[:id])
			fall_in_asleep
		end
	end

	def auto_comment
		medias.each do |media|
			get_media_informations(media)
			puts "[like] id => #{@informations[:id]}"
			comment(@informations[:id],generate_a_comment)
			fall_in_asleep
		end
	end
	
	def generate_a_comment
		# ...
	end

	def fall_in_asleep
		time = options[:wait_per_action]
		puts "waiting for #{time}"
		sleep time
	end


end