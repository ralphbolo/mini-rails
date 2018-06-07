module ActionCable
  autoload :Server, "action_cable/server"
  autoload :Connection, "action_cable/connection.rb"

  def self.server
    @server ||= Server.new
  end
  
end