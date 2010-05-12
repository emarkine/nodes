Dir[File.join(File.dirname(__FILE__), 'lib', 'ext', '**', '*.rb')].each {|ext| require ext }
#ActionController::Base.eugene_helper.unshift File.join(directory, 'views')
#ActionController::Base.append_view_path  "app/views/objects"

