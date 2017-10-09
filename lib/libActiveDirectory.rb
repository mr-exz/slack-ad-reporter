require 'rubygems'
require 'net/ldap'

class SearchUserAD

  def initialize
    @config  = YAML.load_file('./conf/config.yml')
    @treebase = @config['ad_treebase']

    @ldap = Net::LDAP.new :host => @config['ad_server'],
                          :port => @config['ad_port'],
                          :auth => {
                             :method => :simple,
                             :username => @config['ad_user'],
                             :password => @config['ad_password']
                          }
  end

  def find_user_by_email(slack_user)
    user = {}
    user[:mail] = slack_user.profile.email
    user[:ad_status] = 'not found'
    user[:name] = 'not found'
    user[:slack_id] = slack_user.id
    filter_by_email = Net::LDAP::Filter.eq( "mail", "#{user[:mail]}" )

    if slack_user.deleted == false
      user[:slack_status] = 'Not deactivated'
    else
      user[:slack_status] = 'Deactivated'
    end

    @ldap.search( :base => @treebase, :filter => filter_by_email ) do |entry|

      if user_has_email?(entry)
        user[:mail] = entry.mail[0]
        user[:name] = entry.name[0]
      end

      if user_is_active?(entry) == true
        user[:ad_status] = 'enabled'
      elsif user_is_active?(entry) == false
        user[:ad_status] = 'disabled'
      else
        user[:ad_status] = 'unknow'
      end

    end

    return user
  end

  private

  def user_is_active?(entry)
    begin
      if entry.userAccountControl[0] == '512'
        return true
      elsif entry.userAccountControl[0] == '514'
        return false
      else
        return entry.userAccountControl[0]
      end
    rescue
      return nil
    end
  end

  def user_has_email?(entry)
    begin
      entry.mail[0]
      return true
    rescue
      return false
    end
  end
end



