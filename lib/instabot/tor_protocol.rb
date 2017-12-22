require 'mechanize'
module TorProtocol
   class Tor
      # debug
      # Socksify::debug = true

      def initialize(control_port='9051',socks_port='9050')
        puts '[+] '.cyan + "[TOR] STARTED"
        @tor_control_port       = control_port
        @tor_socks_port         = socks_port
        TCPSocket::socks_server = "127.0.0.1"
        TCPSocket::socks_port   = @tor_socks_port
        puts '[+] '.cyan + "[TOR] current ip [#{current_ip.yellow}]"
      end

      def current_ip
        a = Mechanize.new
        a.user_agent_alias = 'Mac Safari'
        return a.get('http://www.myexternalip.com/raw').body.chomp
      rescue Exception => e
        puts "error getting ip: #{e.class} #{e.message}\n#{e.backtrace.inspect}".red
        # break
        # puts "An error occured ... #{e.class} #{e.message}\n#{e.backtrace.inspect}\n[ignored]"
      end

      def get_new_ip
        puts '[+] '.cyan + "[TOR] trying to get a new ip address.."
        old_ip_address = current_ip
        tor_switch_endpoint
        sleep 10
        new_ip_address = current_ip
        if (old_ip_address != new_ip_address)
          puts '[+] '.cyan + "[TOR] ip changed from [#{old_ip_address.yellow}] to [#{new_ip_address.yellow}]"
          return true
         else
          puts '[+] '.yellow + "[TOR] ip same [#{old_ip_address}]"
          get_new_ip
         end
      end

      def tor_switch_endpoint
        # puts "tor_switch_endpoint.."
        tor_protocol = Net::Telnet::new("Host" => "localhost", "Port" => "#{@tor_control_port}", "Timeout" => 10, "Prompt" => /250 OK\n/)
        tor_protocol.cmd('AUTHENTICATE ""') { |c| throw "Cannot authenticate to Tor" if c != "250 OK\n" }
        tor_protocol.cmd('signal NEWNYM') { |c| throw "Cannot switch Tor to new route" if c != "250 OK\n" }
        tor_protocol.close
      end

   end
end


class Mechanize::HTTP::Agent
  public
  def set_socks addr, port
     set_http unless @http
     class << @http
        attr_accessor :socks_addr, :socks_port

        def http_class
          Net::HTTP.SOCKSProxy(socks_addr, socks_port)
        end
     end
     @http.socks_addr = addr
     @http.socks_port = port
  end
end

# tor = Tor.new
# agent = Mechanize.new
# agent.agent.set_socks('localhost', 9050)
# 3.times do |i|
#     puts "##{i}"
#     page  = agent.get('http://myexternalip.com/raw')
#     puts "Body << #{page.body.chomp}..."
#     tor.get_new_ip
# end




