class SoundlikeController < ApplicationController

  def initialize
    @permissionMenu = YAML::load_file("#{Rails.root}/config/soundLikeApp.yaml")
    if File.exist?("#{Rails.root}/config/errMsg.yml")
      @errMsg = YAML::load_file("#{Rails.root}/config/errMsg.yml")
    end
  end

  def not_found
      redirect_to "/notFound.html"
  end

  def music
    unless session[:user_id]
      redirect_to '/login'
    else
      if @errMsg[session[:errMsg]]
        @msgErr = @errMsg[session[:errMsg]]
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
