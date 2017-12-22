module Protocol
  def create_protocol
    if options[:use_tor]
      @tor = TorProtocol::Tor.new
    end
    @agent                  = Mechanize.new
    @agent.max_history      = 2
    # @agent.ca_file          = './cacert.pem' # Because i use windows and... you know... ._.
    @agent.user_agent_alias = ['Mac Mozilla', 'Mac Safari', 'Windows IE 6', 'Windows IE 7', 'Windows IE 8', 'Windows IE 9', 'Windows Mozilla', 'Windows Chrome'].sample
    if options[:use_proxy]
      proxy = options[:proxy]
      if proxy.size == 2
        @agent.set_proxy(proxy[0], proxy[1].to_i)
      else
        @agent.set_proxy(proxy[0], proxy[1].to_i, proxy[2], proxy[3])
      end
    end
    
    if options[:use_tor]
      @agent.agent.set_socks('localhost', 9050)
      log('tor has been started', 'CREATE_PROTOCOL')
    end

    puts 'PROCESSING: '.cyan.bold + 'protocol created'
    log('Protocol successfully created', 'CREATE_PROTOCOL')
  end

  def get_page(url)
    @agent.get(url)
  end

  def set_mechanic_data(params = {})
    @cookies   = Hash[@agent.cookies.map { |key, _value| [key.name, key.value] }]
    @params     = params
    @headers   = {
      'Cookie'           => "mid=#{@cookies['mid']}; csrftoken=#{@cookies['csrftoken']}; sessionid=#{@cookies['sessionid']}; ds_user_id=#{@cookies['ds_user_id']}; rur=#{@cookies['rur']}; s_network=#{@cookies['s_network']}; ig_pr= 1; ig_vw=1920",
      'X-CSRFToken'      => (@cookies['csrftoken']).to_s,
      'X-Requested-With' => 'XMLHttpRequest',
      'Content-Type'     => 'application/x-www-form-urlencoded',
      'X-Instagram-AJAX' => '1',
      'Accept'           => 'application/json, text/javascript, */*',
      'User-Agent'       => 'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0',
      'Accept-Encoding'  => 'gzip, deflate',
      'Accept-Language'  => 'ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4',
      'Connection'       => 'keep-alive',
      'Host'             => 'www.instagram.com',
      'Origin'           => 'https://www.instagram.com',
      'Referer'          => 'https://www.instagram.com/'
    }
  end
end
