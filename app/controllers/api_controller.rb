class ApiController < ApplicationController

  protect_from_forgery except: :display

  def display
    @apiContent = {"result" => "content"}
        desc = "Error"
        dbList = "none"
        content = "none"

    case params[:type]
      when 'music_directories'
        dbList = Sqlite3.new('default')
        content = dbList.userList;
        desc = "List directories"
      when 'users_add'
        desc = "Add new user"
        content = ''
      when 'users_manage'
        desc = "User managment interface"
        dbList = Sqlite3.new('default')
        content = dbList.userList;

    end
    type = params['type'].split('_')
    @apiContent = { 'data' => content, 'type' => type, 'desc' => desc}

    @apiContent.to_json
    respond_to do |format|
      format.js
   end

  end

  def userManage

    userParams = userManageParams
    return_message = ""
    sqlite_params = userParams.clone
    sqlite_params.delete(:id)
    sqlite_params.delete(:utf8)
    sqlite_params.delete(:controller)
    sqlite_params.delete(:action)
    sqlite_params.delete(:name)
    sqlite_params_login = sqlite_params[:login]
    sqlite_params.delete(:login)

    sqlite_co = Sqlite3.new
    case userParams[:id]
      when 'user_modify'
       user_exist = sqlite_co.userExist?(userParams[:login])
       if user_exist
         update_user = sqlite_co.updateUser(sqlite_params_login, sqlite_params)
       else
         return_message = "An error occurred"
       end
    end
    @dd = update_user
    render "def"

  end

end

private

def userManageParams

  userParams = params.clone

  if userParams[:password] and !userParams[:password].empty? and !userParams[:password].match('{MD5}')
    userParams[:password] = md5 userParams[:password]
  end

  userParams

end
