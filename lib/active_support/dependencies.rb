module ActiveSupport
  module Dependencies
    #makes all methods module/class methods
    extend self 

    attr_accessor :autoload_paths
    self.autoload_paths = []

    def search_for_file(name)
      autoload_paths.each do |path|
        file = File.join(path, "#{name}.rb")
        #File.file?(file) Returns true if the named file exists and is a regular file.
        if File.file? file
          return file
        end
      end
      #return nil if name is not in path
      nil
    end
  end
end

class Module
  def const_missing(name)
    if file = ActiveSupport::Dependencies.search_for_file(name.to_s.underscore)
      require file.sub(/\.rb$/, '')

      const_get name
    else
      raise NameError, "Unitialized const #{name}"
    end
  end
end