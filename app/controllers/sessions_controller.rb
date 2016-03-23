class SessionsController < ApplicationController

  def initialize
    @yamlConnect = YAML::load_file("#{Rails.root}/config/soundLike-#{Rails.env}.yaml")
  end

  def login
    dbCheck = dbExist?(@yamlConnect)
    unless dbCheck
      redirect_to '/install'
    else
      if session['errMsg']
         @errMsg = errText session['errMsg']
      end
      render 'sessions/login'
    end
  end

  def new
   if params['session']
     userDatas = checkParams
     if userDatas
        fileDB = @yamlConnect['Sqlite3']['path']
        db = Sqlite3.new(fileDB)
        checkCredentials = db.testCredentials(userDatas)
        if checkCredentials
          log_in(userDatas['username'])
        else
          session['errMsg'] = 99
        end

     else
       session['errMsg'] = 99
     end
   end
   if logged_in?
     redirect_to '/music'
   else
     redirect_to '/login'
   end
  end

  def destroy
    if logged_in?
      log_out
      redirect_to '/login'
    end
  end

end

private

def checkParams
  userData = Hash.new()
  login = params.dig('session', 'username')
  password = params.dig('session', 'password')

  if login.empty? or password.empty?
    userData = false
  else
    userData['username'] = login
    userData['password'] = md5 password
  end
  userData
end
