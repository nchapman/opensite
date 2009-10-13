class Cache
  def initialize(site)
    @site = site
  end
  
  def add(key, value)
    set_site_keys(get_site_keys << key)
    MEM_CACHE.add(key, value)
  end
  
  def get(key)
    self.class.get(key)
  end
  
  def self.get(key)
    MEM_CACHE.get(key)
  end
  
  def delete(key)
    site_keys = get_site_keys
    site_keys.delete(key)
    set_site_keys = site_keys
    MEM_CACHE.delete(key)
  end
  
  def delete_all()
    site_keys = get_site_keys
    site_keys.each { |key| MEM_CACHE.delete(key) }
    set_site_keys = []
  end
  
  private
    def get_site_keys
      MEM_CACHE[@site.cache_key] || []
    end
    
    def set_site_keys(keys)
      MEM_CACHE[@site.cache_key] = keys
    end
end
