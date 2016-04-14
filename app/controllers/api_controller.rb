class ApiController < ApplicationController

  def display
    @apiContent = {"result" => "content"}.to_json

    case params[:type]
      when 'music_directories'
        dbList = Sqlite3.new('default')
        content = dbList.userList;
      when 'users_add'
        content = ''
      when 'users_manage'
        dbList = Sqlite3.new('default')
        content = dbList.userList;
    end

    @apiContent = { 'data' => content, 'type' => params[:type]}

#    render json: @apiContent
#    render :partial => 'soundlike/test', :object => @apiContent
    render :render => 'soundlike/test', :layout => false
  end

  def updateContent

  end

end
