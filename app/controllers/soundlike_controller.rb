class SoundlikeController < ApplicationController

  def initialize
    @permissionMenu = YAML::load_file("#{Rails.root}/config/soundLikeApp.yaml")
  end

  def not_found
      redirect_to "/notFound.html"
  end

  def music
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
