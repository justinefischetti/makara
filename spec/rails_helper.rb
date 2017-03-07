ActiveRecord::Base.logger = Logger.new("log/test_makara.log")
ActiveRecord::Base.logger.level = Logger::WARN
ActiveRecord::Migration.verbose = false
