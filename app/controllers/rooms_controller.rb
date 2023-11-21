class RoomsController < ApplicationController
    
  include RoomsHelper
    
  rescue_from ActiveRecord::RecordNotUnique,with: :errornotunique
    
  def show
     @user = current_user
     @room = Room.find(params[:format])
     @floor = Floor.find((@room.roomnumber/1000).round(0))
     @notes = Note.order('created_at desc')
     @alerts = Alert.order('created_at desc')
  end
  
  def confirm
      @user = current_user
      @room = Room.find(params[:format])
      if
      (params[:room][:petname]) == ""
      render 'blank'
      current_user.rmcounter = current_user.rmcounter + 1
      else
      @room.update(room_params)
      end
      if @room.save
      @floor = Floor.find((@room.roomnumber/1000).round(0))
      current_user.rmcounter = current_user.rmcounter - 1
      user = current_user
      user.save
      else
      render 'blank'
      end
  end
  
  def blank
      @user = current_user
      @room = Room.find(params[:format])
      @floor = Floor.find((@room.roomnumber/1000).round(0))
  end
  
  def move
      @room = Room.find(params[:format])
      @floor = Floor.find((@room.roomnumber/1000).round(0))
  end
  
  def moved
      @user = current_user
      @room = Room.find(params[:format])
      @floor = Floor.find((@room.roomnumber/1000).round(0))
      @room.remove_frame01!
      @room.remove_frame02!
      @room.remove_frame03!
      @room.remove_frame04!
      @room.remove_frame05!
      @room.remove_frame06!
      @room.remove_frame07!
      @room.remove_frame08!
      @room.remove_frame09!
      @room.remove_frame10!
      @room.remove_roomface!
      @room.owner_id = nil
      @room.ownername = nil
      @room.petname = nil
      @room.rentcomment = nil
      @room.frm01comment = nil
      @room.frm02comment = nil
      @room.frm03comment = nil
      @room.frm04comment = nil
      @room.frm05comment = nil
      @room.created_notes.delete
      room = @room
      room.save
      @room.created_alerts.delete_all
      current_user.rmcounter = current_user.rmcounter + 1
      user = current_user
      user.save
  end
  
  def reset
      @user = current_user
      @room = Room.find(params[:format])
      @room.remove_frame01!
      @room.remove_frame02!
      @room.remove_frame03!
      @room.remove_frame04!
      @room.remove_frame05!
      @room.remove_frame06!
      @room.remove_frame07!
      @room.remove_frame08!
      @room.remove_frame09!
      @room.remove_frame10!
      @room.remove_roomface!
      @room.save
      @floor = Floor.find((@room.roomnumber/1000).round(0))
  end
  
  def edit
      @user = current_user
      @room = Room.find(params[:format])
  end
  
  def update
      @user = current_user
      @room = Room.find(params[:format])
      @room.update(room_params)
      @floor = Floor.find((@room.roomnumber/1000).round(0))
  end
  
  def errornotunique(e)
      render 'notunique',formats: [:html]
  end
  
  def commented
      @user = current_user
      @room = Room.find(params[:format])
      @floor = Floor.find((@room.roomnumber/1000).round(0))
      @alerts = Alert.order('created_at desc')
      note = current_user.created_notes.build do |n|
          n.room_id = params[:format]
          n.user_id = current_user.id
          n.comment = params[:note][:comment]
          n.petname = params[:note][:petname]
      end
      note.save
      @notes = Note.order('created_at desc')
      render:show
  end
  
  def alerted
      @user = current_user
      @room = Room.find(params[:format])
      @floor = Floor.find((@room.roomnumber/1000).round(0))
      alert = current_user.created_alerts.build do |a|
          a.room_id = params[:format]
          a.user_id = current_user.id
          a.petname = params[:alert][:petname]
      end
      alert.save
  end

  
  private
          
  def room_params
      params.require(:room).permit(
                                   :petname, :rentcomment, :owner_id, :ownername, :frame01, :frame02, :frame03, :frame04, :frame05, :frame06, :frame07, :frame08, :frame09, :frame10, :frame01_cache, :frame02_cache, :frame03_cache, :frame04_cache, :frame05_cache, :frame06_cache, :frame07_cache, :frame08_cache, :frame09_cache, :frame10_cache, :frm01comment, :frm02comment, :frm03comment, :frm04comment, :frm05comment, :roomface, :roomface_cache
                                    )
  end
  
  def note_params
      params.require(:note).permit(
                                   :comment, :user_id, :room_id, :petname
                                   )
  end
  
  def alert_params
      params.require(:alert).permit(
                                    :user_id, :room_id, :petname
                                    )
  end
end
