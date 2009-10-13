APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file("#{RAILS_ROOT}/config/config.yml"))[RAILS_ENV]
