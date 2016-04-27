class ApiController < ApplicationController

  protect_from_forgery except: :display

  def display
    @apiContent = {"result" => "content"}.to_json

    case params[:type]
      when 'music_directories'
        dbList = Sqlite3.new('default')
        content = dbList.userList;
      when 'users_add'
        content = 'dd'
      when 'users_manage'
        desc = "Welcome to the user managment interface"
        dbList = Sqlite3.new('default')
        content = dbList.userList;
    end

    @apiContent = { 'data' => content, 'type' => params[:type], 'desc' => desc}

    @apiContent.to_json
    respond_to do |format|
      format.js
   end

  end

end
