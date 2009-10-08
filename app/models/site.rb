class Site < ActiveRecord::Base
  has_many :pages
  has_many :templates
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :domains
  has_many :textual_assets
  has_many :style_sheets
  has_many :javascripts
  has_many :images
  
  validates_presence_of :name
  validates_format_of :subdomain, :with => /^[a-z0-9]+$/, :on => :create, :message => "can only contain lowercase letters and numbers"
  validates_uniqueness_of :subdomain, :message => "is already taken"
  
  accepts_nested_attributes_for :domains, :allow_destroy => true, :reject_if => proc { |d| d["fqdn"].blank? }
  
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
  
  def self.find_by_domain(host)
    return Site.find_by_domain!(host)
  rescue
    return nil
  end
end
