Dir.glob('./modules/*.rb').each do |file|
	require_relative file
end
