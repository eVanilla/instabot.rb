module Protocol
	def create_mechanic
		puts Dir.glob("")
		@agent 					= Mechanize.new
		@agent.max_history 		= 2
		# @agent.log 				= Logger.new(STDOUT)
		@agent.ca_file			= "#@lib_dir/cacert.pem"
		@agent.user_agent_alias = "Mac Safari"
		# @agent.set_proxy()
		custom_print "PROCESSING: ".cyan.bold + "protocol created"
	end


	def get_page(url)
		@page = @agent.get(url)
		# @temp_jar = @agent.cookie_jar
		# @temp_jar.save("#{@lib_dir}/cookies.yaml", session: true)	# => saving the cookies
	end


	def set_mechanic_data(params={})
			@cookies 	= Hash[@agent.cookies.map {|key, value| [key.name, key.value]}]
			@params 	= params
			@headers 	= {	
							'Cookie' 			=> "mid=#{@cookies['mid']}; csrftoken=#{@cookies['csrftoken']}; sessionid=#{@cookies['sessionid']}; ds_user_id=#{@cookies['ds_user_id']}; rur=#{@cookies['rur']}; s_network=#{@cookies['s_network']}; ig_pr= 1; ig_vw=1920",
							'X-CSRFToken' 		=> "#{@cookies['csrftoken']}",
							'X-Requested-With' 	=> 'XMLHttpRequest',
							'Content-Type' 		=> 'application/x-www-form-urlencoded',
							'X-Instagram-AJAX' 	=> '1',
							'Accept' 			=> 'application/json, text/javascript, */*',
							'User-Agent' 		=> 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0',
							'Accept-Encoding' 	=> 'gzip, deflate',
							'Accept-Language' 	=> "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4",
							'Connection' 		=> 'keep-alive',
							# 'Content-Length' 	=> '0',
							'Host' 				=> 'www.instagram.com',
							'Origin' 			=> 'https://www.instagram.com',
							'Referer' 			=> 'https://www.instagram.com/'
						}
	end

end