module CanCan
  module ModelAdapters
    class MongoidAdapter
      # Override the find method so that pretty urls would work with cancan (things like /datacenters/ladc5 etc)
      def self.find(model_class, id)
        model_class.any_of({_id: id}, {name: id.gsub('-', '.')}).first
      end
    end
  end
end
