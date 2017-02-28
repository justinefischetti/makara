require 'active_record/connection_adapters/makara_abstract_adapter'

class FakeConnection < Struct.new(:config)

  def ping
    'ping!'
  end

  def irespondtothis
    'hey!'
  end

  def query(content)
    []
  end

  def active?
    true
  end

  def disconnect!
    true
  end

  def something
    (config || {})[:something]
  end
end

class FakeDatabaseAdapter < Struct.new(:config)

  def execute(sql, name = nil)
    []
  end

  def exec_query(sql, name = 'SQL', binds = [])
    []
  end

  def select_rows(sql, name = nil)
    []
  end

  def active?
    true
  end

  def connection
    FakeConnection.new({})
  end

end

class FakeProxy < Makara::Proxy

  send_to_all :ping
  hijack_method :execute
  hijack_method :connection

  def connection_for(config)
    FakeConnection.new(config)
  end

  def needs_master?(method_name, args)
    return false if args.first =~ /^select/
    true
  end
end

class FakeAdapter < ::ActiveRecord::ConnectionAdapters::MakaraAbstractAdapter
  def connection_for(config)
    FakeDatabaseAdapter.new(config)
  end
end
