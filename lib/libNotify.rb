require 'mail'
require 'yaml'
require 'erb'

class Notify

	def initialize

		@config  = YAML.load_file('./conf/config.yml')

		@options = {:address              => @config['mail_server'],
								:port                 => @config['mail_server_port'],
								:domain               => @config['domain'],
								:user_name            => @config['mail_user'],
								:password             => @config['mail_password'],
								:authentication       => @config['authentication_type'],
								:enable_starttls_auto => @config['use_starttls']
		}

	end

	def send(data)
		@user_list = data

		mail = Mail.new
		mail.delivery_method :smtp, @options

		mail.from @config['mail_user']
		mail.to @config['contact_mail']
		mail.subject @config['subject']
		mail.content_type 'text/html; charset=UTF-8'
		mail.body ERB.new(File.read('./template/index.erb')).result(binding)

		mail.deliver
	end

end	










