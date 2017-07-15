module Nodes
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def init
      @controller = params[:controller]
      if not %w(site user_sessions).include?(@controller)
        @object_name = @controller.singularize
        @model = @controller.singularize.split('/').map {|c| c.capitalize}.join('::').constantize if @controller
        @object = @model.find_by_id(params[:id]) if (params[:id] && @model)
      end
    end

    # ASC | DESC
    def sort
      if session[:sort] == params[:field] #change sort direction
        if session[:sort_direction] == 'DESC'
          session[:sort_direction] = 'ASC'
        else
          session[:sort_direction] = 'DESC'
        end
      else # create new sort direction
        session[:sort] = params[:field]
        session[:sort_direction] = 'ASC'
      end

      list = @model.all
      if session[:sort_direction] == 'ASC'
        list.to_a.sort! do |one, two|
          a = one.send(session[:sort])
          b = two.send(session[:sort])
          (a and b) ? a <=> b : (a ? -1 : 1)
        end
      else
        list.to_a.sort! do |one, two|
          a = one.send(session[:sort])
          b = two.send(session[:sort])
          (b and a) ? b <=> a : (b ? -1 : 1)
        end
      end
      instance_variable_set("@#{@controller}", list)
      render action: :index
    end

  end
end
