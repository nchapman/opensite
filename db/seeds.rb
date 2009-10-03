# The data can be loaded with the rake db:seed (or created alongside the db with db:setup).

user = User.create!(:first_name => "System", :last_name => "Administrator", :email => "admin@opensizzle.com", :admin => true, :password => "admin", :password_confirmation => "admin")

site = Site.new(:name => "Open Site", :subdomain => "opensite")
site.users << user
site.save!

site.templates.create!(:title => "Default", :body => <<-BODY
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><os:title /></title>
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.8.0r4/build/reset-fonts/reset-fonts.css&2.8.0r4/build/base/base-min.css" />
  </head>
  <body>
    <h1><os:title /></h1>
    <p><os:body /></p>
  </body>
</html>
BODY
)

site.pages.create!(:title => "Welcome to Open Site", :home => true, :slug => "home", :body => "We're so glad you stopped by.", :created_by => user, :updated_by => user)