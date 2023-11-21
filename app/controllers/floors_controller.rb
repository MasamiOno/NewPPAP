class FloorsController < ApplicationController
  def show
      @user = current_user
      @floor = Floor.find(params[:format])
      @rooms = Room.order('created_at asc')
  end
end
