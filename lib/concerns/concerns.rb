module Concerns
  
  module Findable
    def find_by_name(name)
      self.all.detect do |obj|
        obj.name == name
      end
    end
  
    def find_or_create_by_name(name)
      find_by_name(name) || self.create(name)
    end
  end
  
end