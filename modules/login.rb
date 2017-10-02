module Login

	def login
	
		login_page = @agent.get("https://www.instagram.com/accounts/login/?force_classic_login")
		page_form = login_page.forms.last
		page_form.username = options[:username]
		page_form.password = options[:password]
		page = page_form.submit
		@login_status = true
	
	rescue Exception => e

		@login_status = false
		puts "#{e.class} #{e.message}\n====================\n#{e}".red
	
	end

	def check_login_status

		unless @login_status
			
			puts "you're not logged in.".red.bold
			login

		end

	end

end