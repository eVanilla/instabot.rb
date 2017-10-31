module Banner

  def print_banner()
  	if options[:print_banner]
    	puts <<-BANNER
 ██╗███╗   ██╗███████╗████████╗ █████╗ ██████╗  ██████╗ ████████╗
 ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝
 ██║██╔██╗ ██║███████╗   ██║   ███████║██████╔╝██║   ██║   ██║   
 ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██╔══██╗██║   ██║   ██║   
 ██║██║ ╚████║███████║   ██║   ██║  ██║██████╔╝╚██████╔╝   ██║   
 ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝   

    	BANNER
    	puts "A instagram bot works without IG api".white.bold + " #Author ".yellow + "github.com/eVanilla".cyan
  	end
  end

end