module ActiveTag
  module Document
    def self.included(base)
      base.class_eval do
        include InstanceMethods
        extend ClassMethods

      end
    end


    module ClassMethods
      def all
           Array.new
      end
    end

    module InstanceMethods
      def name
        "name"
      end
    end


  end
end