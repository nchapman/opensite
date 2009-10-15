# The data can be loaded with the rake db:seed (or created alongside the db with db:setup).

user = User.create!(:first_name => "System", :last_name => "Administrator", :email => "admin@opensizzle.com", :admin => true, :password => "admin", :password_confirmation => "admin")

site = Site.new(:name => "Open Site", :subdomain => "opensite", :created_by => user, :updated_by => user)
site.users << user
site.domains << Domain.new(:fqdn => "localhost")
site.domains << Domain.new(:fqdn => APP_CONFIG["host_domain"])
site.save!
