require 'slack-ruby-client'

class InfoSlack

  def initialize
    @config  = YAML.load_file('./conf/config.yml')

    Slack.configure do |config|
      config.token = @config['slack_token']
    end

    @client = Slack::Web::Client.new
  end

  def user_list
    return @client.users_list['members']
  end

  def users_info (user_id)
    return @client.users_info(user: "#{user_id}")
  end

  def users_profile_set (user)
    status = {:status_text=>"Home", :status_emoji=>":house_with_garden:"}
    return @client.users_profile_set(user: user, profile: status.to_json)
  end
end


