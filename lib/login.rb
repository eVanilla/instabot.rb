module Login

	def login
		log("trying to login")
		custom_print "[+] ".cyan + "Trying to login into [#{options[:username]}] account"
		login_page = @agent.get("https://www.instagram.com/accounts/login/?force_classic_login")
		page_form = login_page.forms.last
		page_form.username = options[:username]
		page_form.password = options[:password]
		page = page_form.submit
		@login_status = true
		log("successfully logged in")
		custom_print "[+] ".cyan + "Successfully logged in".green.bold
		puts
	rescue Exception => e
		log("a error detected: #{e.class} #{e}")
		@login_status = false
		custom_print "[-] ".cyan + "#{e.class} #{e.message}\n#{e}".red
	end

	def logout
		log("trying to logout")
		custom_print "[+] ".cyan + "Trying to logging out"
		logout_page = @agent.get("https://www.instagram.com/accounts/logout/")
		@logout_status = true
		log("successfully logged out")
		custom_print "[+] ".cyan + "Successfully logged out"
	end

	def check_login_status
		custom_print "[+] ".cyan + "Checking login status"
		log("checking loging status")
		unless @login_status
			
			custom_print "[-] ".cyan + "you're not logged in.".red.bold
			login

		end
	end

end