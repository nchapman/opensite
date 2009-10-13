require "memcache"

MEM_CACHE = MemCache.new("0.0.0.0:11211", :namespace => "os:")
