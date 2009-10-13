require "memcache"

if APP_CONFIG[:mem_cache][:enabled]
  MEM_CACHE = MemCache.new(APP_CONFIG[:mem_cache][:servers])
end
