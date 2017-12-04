module Login
  def login(username = '', password = '')
    if @login_mode == :manual
      username = username.to_s
      password = password.to_s
    else
      username = options[:username]
      password = options[:password]
    end

    log('trying to login', 'LOGIN')
    puts '[+] '.cyan + "Trying to login into [#{username}] account"
    login_page         = @agent.get('https://www.instagram.com/accounts/login/?force_classic_login')
    page_form          = login_page.forms.last
    page_form.username = username
    page_form.password = password
    page               = page_form.submit

    if page.code == '200' && page.uri.to_s != 'https://www.instagram.com/accounts/login/?force_classic_login' && !page.uri.to_s.include?('challenge')
      @login_status = true
      log('successfully logged in', 'LOGIN')
      puts '[+] '.cyan + 'Successfully logged in'.green.bold
    else
      @login_status = false
      if page.uri.to_s.include?('challenge')
        puts '[-] '.cyan + 'Your account needs veryfication or it has been banned from instagram'.red.bold
      else
        puts '[-] '.cyan + 'Invalid username or password'.red.bold
      end
      check_login_status
    end

  rescue Exception => e
    log("an error detected: #{e.class} #{e} #{e.backtrace}", 'LOGIN')
    @login_status = false
    puts '[-] '.cyan + "#{e.class} #{e.message}\n check out the log file for full trace ".red
    exit
  end

  def logout
    log('trying to logout', 'LOGIN')
    puts '[+] '.cyan + 'Trying to logging out'
    set_mechanic_data
    @agent.get('https://www.instagram.com/accounts/logout/')
    @logout_status = true
    log('successfully logged out', 'LOGIN')
    puts '[+] '.cyan + 'Successfully logged out'
  end

  def check_login_status(_mode = :default)
    puts '[+] '.cyan + 'Checking login status' if @login_mode != :manual
    log('checking loging status', 'LOGIN')
    if @login_status
      return true
    else
      puts "[-] [##{@login_counter}] ".cyan + "You're not logged in (or it is an error with the request)\t[TRYING AGAIN]".red.bold
      exit! if @login_counter == 3
      @login_counter += 1
      login
    end
  end
end
