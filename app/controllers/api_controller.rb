class ApiController < ApplicationController

  protect_from_forgery except: :display

  def display
    @apiContent = {"result" => "content"}
        desc = "Error"
        dbList = "none"
        content = "none"

    case params[:type]
      when 'music_directories'
        content = "dddaaaassssqqqq"
        desc = "List directories"
      when 'users_add'
        desc = "Add new user"
        content = {"new_user" => {"password" => '', "admin" => 0 }}
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
    sqlite_params.delete(:commit)

    if params[:name].empty?
      session[:errMsg] = 99
      redirect_to '/music'
    else
      sqlite_co = Sqlite3.new
      user_exist = sqlite_co.userExist?(userParams[:name])
      case userParams[:id]
        when 'user_add'
          sqlite_params[:login] = sqlite_params[:name]
          sqlite_params.delete(:name)
          unless user_exist
            unless params[:admin]
              sqlite_params_admin = 0
            else
              sqlite_params_admin = 1
            end
            sqlite_params.delete(:admin)
            result_user = sqlite_co.createUser(sqlite_params, sqlite_params_admin)
            session[:errMsg] = 1.0
          else
            session[:errMsg] = 1.8
          end
        when 'user_manage'
          if user_exist
            sqlite_params_login = sqlite_params[:name]
            sqlite_params.delete(:login)
            sqlite_params.delete(:name)
            unless sqlite_params[:admin]
              sqlite_params[:admin] = 0
            end
            result_user = sqlite_co.updateUser(sqlite_params_login, sqlite_params)
            session[:errMsg] = 2.0
          else
            session[:errMsg] = 2.8
          end
        when 'user_delete'
          if user_exist
            result_user = sqlite_co.delUser(sqlite_params[:name])
            session[:errMsg] = 2.1
          else
            session[:errMsg] = 2.9
          end
      end
      @dd = result_user
      redirect_to '/music'
    end

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
