Dir.glob("#{Dir.pwd}/modules/*.rb").each {|file| require_relative file}
%w[colorize fileutils io/console mechanize logger pp].each {|gem| require gem} 