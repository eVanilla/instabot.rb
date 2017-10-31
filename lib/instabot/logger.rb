module Log

	def check_log_files
		custom_print "PROCESSING: ".cyan.bold + "checking log files"
		if !File.exists?(@logs_dir)
			Dir.mkdir(@logs_dir)
		end
		
		if File.exists?("#{@logs_dir}/logs.log")
			# File.delete("#{@logs_dir}/logs.log")
		end
	end

	def write_file(filename, text="")
		File.open("#{@logs_dir}/#{filename}", "a+") {|file| file.print "#{text.chomp},"}
	end

	def log(text="",from="")
		time = Time.new.strftime("%H:%M:%S %y-%m-%d")
		File.open("#{@logs_dir}/logs-#{@global_time}.log","a+") do |log_file|
			log_file.puts "[#{@log_counter}] [#{time}] [#{from}] -- : #{text}"
		end
		@log_counter += 1
	end

	def save_action_data(id=0,type=:default)
		case type
		when :follow
			write_file("followed_users.txt",id)
		when :unfollow
			write_file("unfollowed_users.txt",id)
		when :like
			write_file("liked_medias.txt",id)
		when :comment
			write_file("commented_medias.txt",id)
		when :default
			puts "please choice a type"
		else
			puts "please choice a type"
		end
	end

end	


