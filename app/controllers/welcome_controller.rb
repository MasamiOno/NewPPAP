class WelcomeController < ApplicationController
  PER = 10

  def index
      #@user = current_user
      #@floors = Floor.page(params[:page]).per(PER).order(created_at: :desc)
      #!@q = Room.page(params[:page]).per(PER).order(created_at: :asc).search(search_params)
      #@rooms = @q.result(distinct: true)
  end
  
  def roomsearch
      @user = current_user
      @floors = Floor.page(params[:page]).per(PER).order(created_at: :desc)
      @q = Room.page(params[:page]).per(PER).order(created_at: :asc).search(search_params)
      @rooms = @q.result(distinct: true)
  end
  
  def generate
      @user = current_user
      @floors = Floor.order('created_at desc')
      @q = Room.page(params[:page]).per(PER).order(created_at: :asc).search(search_params)
      @rooms = @q.result(distinct: true)
      
      i = 0
      j = params[:roomnumber].to_i
      while i < 30
          room = Room.create do |r|
              r.roomnumber = j
              j += 1
          end
          i += 1
      end
  end
  
  def search_params
      params.require(:q).permit!
      rescue
      { petname: nil }
  end
end
