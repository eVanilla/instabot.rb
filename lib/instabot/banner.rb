module Banner
  def print_banner
    if options[:print_banner]
      puts <<-BANNER
 ██╗███╗   ██╗███████╗████████╗ █████╗ ██████╗  ██████╗ ████████╗
 ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝
 ██║██╔██╗ ██║███████╗   ██║   ███████║██████╔╝██║   ██║   ██║
 ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██╔══██╗██║   ██║   ██║
 ██║██║ ╚████║███████║   ██║   ██║  ██║██████╔╝╚██████╔╝   ██║
 ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝

        BANNER
      puts 'An instagram bot works without instagram api '.white.bold + 'github.com/'.cyan + "eVanilla/instabot.rb\n".cyan.bold.italic
    end
  end
end
