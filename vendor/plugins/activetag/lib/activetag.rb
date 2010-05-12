require "rubygems"
gem "mongo"

require "mongo"


module ActiveTag

  class << self

    def config
      config = ActiveTag::Config.instance
      block_given? ? yield(config) : config
    end

     alias :config :configure
  end

   ActiveTag::Config.public_instance_methods(false).each do |name|
    (class << self; self; end).class_eval <<-EOT
      def #{name}(*args)
        configure.send("#{name}", *args)
      end
    EOT
  end

end
