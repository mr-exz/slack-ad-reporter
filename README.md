# Slack AD Sync

## Description

* Get users from Slack
* Check user status in Active Directory
* Send email report to Administrator

![image](doc/report.png)

## Start Lab

```
# git clone https://github.com/mr-exz/slack-ad-reporter.git
# cd ./sslack-ad-reporter/vagrant
# ssh-keygen -f vagrant
# vagrant up
# vagrant ssh
# sudo -s
```

## Configure

In ```./conf/``` directory you should define ```config.yml```

```yaml

# Mail Settings
mail_server: smtp.gmail.com
mail_server_port: 587
domain: example.com
mail_user: info@example.com
mail_password: R0b0tUnicorn
authentication_type: plain
use_starttls: true

# Administrator contact
contact_mail: root@example.com

subject: Slack Active Directory report

# Active Directory Settings
ad_server: 127.0.0.1
ad_port: 389 # LDAPS not support
ad_user: CN=Administrator,CN=Users,DC=example,DC=local
ad_password: R0b0tUnicorn
ad_treebase: DC=example,DC=local

# Slack Settings
slack_token: xoxp-0000000000000000-000000000000-0000000000000-0000000000000000000000

```

## Usage in Vagrant

```
# cd /opt/slack-ad-reporter
# ./bin/slack-report
```