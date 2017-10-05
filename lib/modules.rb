Dir.glob("#{Dir.pwd}/modules/*.rb").each {|file| require_relative file}
%w[colorize fileutils io/console mechanize hashie json logger pp].each {|gem| require gem} 