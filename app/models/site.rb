class Site < ActiveRecord::Base
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
  
  def cache_key
    "site:#{self.id}"
  end
  
  def self.find_by_domain!(host)
    domain = Domain.find_by_fqdn(host, :include => [:site])
    
    if domain
      return domain.site
    elsif host =~ /([^\.]+)\.#{APP_CONFIG["host_domain"]}/
      return Site.find_by_subdomain!($1)
    else
      raise "not found"
    end
  end
end
