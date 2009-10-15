class Site < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  has_many :domains, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :javascripts, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :snippets, :dependent => :destroy
  has_many :style_sheets, :dependent => :destroy
  has_many :templates, :dependent => :destroy
  has_many :textual_assets, :dependent => :destroy
  has_many :users, :through => :memberships
  
  validates_presence_of :name
  validates_format_of :subdomain, :with => /^[a-z0-9]+$/, :on => :create, :message => "can only contain lowercase letters and numbers"
  validates_uniqueness_of :subdomain, :message => "is already taken"
  
  accepts_nested_attributes_for :domains, :allow_destroy => true, :reject_if => proc { |d| d["fqdn"].blank? }
  
  def url
    "http://#{self.subdomain}.#{APP_CONFIG[:host_domain]}"
  end
  
  def cache_key
    "site:#{self.id}"
  end
  
  def self.find_by_domain!(host)
    domain = Domain.find_by_fqdn(host, :include => [:site])
    
    if domain
      return domain.site
    elsif host =~ /([^\.]+)\.#{APP_CONFIG[:host_domain]}/
      return Site.find_by_subdomain!($1)
    else
      raise "not found"
    end
  end
  
  def after_create
    self.templates.create!(:name => "Default", :created_by => self.created_by, :updated_by => self.updated_by, :content => <<-CONTENT
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title><os:title /></title>
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.8.0r4/build/reset-fonts/reset-fonts.css&2.8.0r4/build/base/base-min.css" />
      </head>
      <body>
        <h1><os:title /></h1>
        <p><os:content /></p>
      </body>
    </html>
    CONTENT
    )

    page = self.pages.new(:title => "Welcome!", :home => true, :slug => "home", :created_by => self.created_by, :updated_by => self.updated_by)

    page.parts << PagePart.new(:name => "body", :content => "We're so glad you stopped by.")

    page.save!
  end
  
  def prepare_context(context)
    context.globals.site = self
    
    context.define_tag "site", :for => self, :expose => [:name]
  end
end
