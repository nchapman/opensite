class CacheObserver < ActiveRecord::Observer
  observe :page, :template, :snippet, :javascript, :style_sheet
  
  def after_save(object)
    cache = Cache.new(object.site)
    cache.delete_all
  end
  
  def after_destroy(object)
    cache = Cache.new(object.site)
    cache.delete_all
  end
end