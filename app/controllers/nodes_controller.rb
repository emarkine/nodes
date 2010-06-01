class NodesController < ApplicationController

  def index
    @nodes = Node.all
  end

  def show
    @node = Node.find params[:id]
    unless @node
      flash[:error] = "Cant find node with id => #{params[:id]}"
      redirect_to :action => :index
    end
  end

  def edit
    @node = Node.find params[:id]
    @title = @node.name
  end

  def new
    if params[:id]
      @src = Node.find params[:id]
#			@node = @src.clone
      @node = Node.new
      @node.name = @src.name
    else
      @node = Node.new
    end
  end

  def update
    @node = Node.find params[:id]
    if @node.update_attributes params[:node]
      redirect_to :action => 'show', :id => @node
      flash[:notice] = "Node was updated"
    else
      render :action => 'edit'
    end
  end

  def create
    key = params[:key]
    value = params[:value]
    if key.blank?
      flash[:error] = "Please enter key"
      render :action => 'new'
    else
      @node = Node.new
      @node[key] ||= value
      if @node.save
        flash[:notice] = "Node was created"
        redirect_to :action => 'show', :id => @node.id
      else
        render :action => 'new'
      end
    end
  end


  def destroy
    @node = Node.find params[:id]
    @node.destroy
    redirect_to :action => 'index'
  end


  def add_key
    @node = Node.find params[:id]
    if @node && params[:text]
      @node[params[:text]] ||= nil
      @node.save
    end
  end


end
