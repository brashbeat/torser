task :gen_mail_config do
	File.open(Rails.root.to_s + '/config/mail_config.json' , 'w+') do |pge|
		json_string = '{ "address": "something",
	  		  "port": 2525,
			  "domain":    "something",
			  "user_name": "something",
			  "password": "something",
			  "authentication": "something",
			  "enable_starttls_auto": true,
			  "to_address": "something" 
			}'
		pge << json_string	
	end
	puts "Created mail_config.json at " + Rails.root.to_s + '/config/mail_config.json'
	puts "These values are just placeholders and will not work if used as/is." 
end