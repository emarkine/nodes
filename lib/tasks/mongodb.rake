namespace :mongodb do
	# start db server
	task :start do
		sh "/usr/local/mongodb/bin/mongod &"
#			sh "/usr/local/mongo/bin/mongod run --dbpath=#{Rails.root}/data/ &"
		puts "mongod running - press return"
	end


	# stop db server
	task :stop do
		require 'SysControl'
		SysControl.kill("mongod")
	end

end