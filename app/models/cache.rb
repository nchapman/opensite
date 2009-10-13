class Cache
    def self.get(key)
      MEM_CACHE[MEM_CACHE[key]]
    end
    
    def self.get_by_url(url)
      MEM_CACHE[url]
    end
    
    def self.add(key, url, content)
      MEM_CACHE[key] = url
      MEM_CACHE[url] = content
    end
    
    def self.delete(key)
      MEM_CACHE.delete(MEM_CACHE[key])
      MEM_CACHE.delete(key)
    end

end
