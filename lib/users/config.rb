module UsersFeatures
  class Config    
    class << self
      def path
        File.expand_path('../../../',  __FILE__)
      end
    end
  end
end