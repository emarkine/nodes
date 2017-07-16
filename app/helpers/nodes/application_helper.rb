module Nodes
  module ApplicationHelper
    def form_error(o)
      if o.errors.any?
        haml_tag :div, :id => 'error_explanation' do
          haml_tag :h2 do
            haml_concat t(:error_save)
          end
          haml_tag :ul do
            o.errors.full_messages.each do |msg|
              haml_tag :li do
                haml_concat msg
              end
            end
          end
        end
      end
    end

  end
end
