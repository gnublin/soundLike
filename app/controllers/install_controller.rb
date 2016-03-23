class InstallController < ApplicationController
  def initialize
    @configFile = "#{Rails.root}/config/soundLike-#{Rails.env}.yaml"
    @yamlConnect = YAML::load_file(@configFile)
  end

  def install
    if session[:msgErr] == 0
      @msgErr = "OK: success"
    elsif session[:msgErr]
      @msgErr = "NOK: "
    end
    session.delete(:msgErr)
    if @yamlConnect['Sqlite3'] and @yamlConnect['Sqlite3']['path'] and File.exist?(@yamlConnect['Sqlite3']['path']) and Sqlite3.new(@yamlConnect['Sqlite3']['path']).tableExist?('users') and Sqlite3.new(@yamlConnect['Sqlite3']['path']).userExist?('admin')
        @alreadInstalled = true
        @title = "Your application is already configured. If you want to re-install, you should contact your administrator or remove the Sqlite3 database.
        You will be redirect to login page in 3 secondes..."
    else
      @alreadyInstalled = false
      @titleCo = @yamlConnect.clone
      @titleCo['Sqlite3']['login'] = 'admin'
      @titleCo['Sqlite3']['password'] = md5 'admin'
      @alreadInstalled = false
      @title = "Your Application is not configured yet. You can do it now!"
    end
    render layout: 'install'
  end

  def save
    data = saveParams
    yamlR = writeYaml(@configFile, data['yaml'])
    yamlUpdated = YAML::load_file(@configFile)
    db = Sqlite3.new(yamlUpdated['Sqlite3']['path'])
    unless db.tableExist?('users')
      db.createUsersDB('users')
    end
    unless db.userExist?('admin')
      db.createUser(data['user'],1)
    end
    result = db.userExist?('admin')
    p result
    if result == true
      session[:msgErr] = 0
    else
      session[:msgErr] = 1
    end
    ref = request.referer
    uri = URI(request.referer).path
		if URI(request.referer).query
    	uparams = URI::decode_www_form(URI(request.referer).query).to_h
    	uparams.delete("msgErr")
			uparams = "?#{uparams.to_query}"
		else
			uparams=''
		end
    url = "#{uri}#{uparams}"
    redirect_to "#{url}"
  end

end

private
  def saveParams
    data = Hash.new
    saveData = Hash.new
    yaml = params.clone
    yaml.each do |label, value|
      if label == 'controller' or label == 'action'
        next
      end
      tabName = label.split('_')
      name = tabName[0]
      newLabel = tabName[1]
      unless data[name]
        data[name] = Hash.new
      end
      data[name][newLabel] = value
    end
    dataDB = data['Sqlite3'].clone
    dataDB.delete('path')
    data['Sqlite3'].delete('login')
    data['Sqlite3'].delete('password')
    saveData['user'] = dataDB
    saveData['yaml'] = data
    saveData
  end
