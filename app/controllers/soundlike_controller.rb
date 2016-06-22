class SoundlikeController < ApplicationController

  def initialize
    @permissionMenu = YAML::load_file("#{Rails.root}/config/soundLikeApp.yaml")
  end

  def not_found
      redirect_to "/notFound.html"
  end

  def music
    unless session[:user_id]
      redirect_to '/login'
    else
      if session[:errMsg] == 0
        @msgErr = "OK: success"
      elsif session[:errMsg]
        @msgErr = "NOK: an error occured"
      end
      session.delete(:errMsg)
      username = session['user_id']
      isAdmin = Sqlite3.new('default').isAdmin(username)
      @menu = @permissionMenu['menu'][isAdmin]
      @menuLeft = Hash.new()
      @menu.each do |menuEntry|
        @menuLeft[menuEntry] = @permissionMenu['menuLeft'][menuEntry]
      end

      render layout: 'soundlike'
    end

  end


end
