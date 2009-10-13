class Cache
  @@enabled = APP_CONFIG[:mem_cache][:enabled]
  
  def initialize(site)
    @site = site
  end
  
  def add(key, value)
    if @@enabled
      set_site_keys(get_site_keys << key)
      MEM_CACHE.add(key, value)
    end
  end
  
  def get(key)
    self.class.get(key) if @@enabled
  end
  
  def self.get(key)
    MEM_CACHE.get(key) if @@enabled
  end
  
  def delete(key)
    if @@enabled
      site_keys = get_site_keys
      site_keys.delete(key)
      set_site_keys = site_keys
      MEM_CACHE.delete(key)
    end
  end
  
  def delete_all()
    if @@enabled
      site_keys = get_site_keys
      site_keys.each { |key| MEM_CACHE.delete(key) }
      set_site_keys = []
    end
  end
  
  private
    def get_site_keys
      MEM_CACHE[@site.cache_key] || []
    end
    
    def set_site_keys(keys)
      MEM_CACHE[@site.cache_key] = keys
    end
end
