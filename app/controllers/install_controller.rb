class InstallController < ApplicationController
  def initialize
    @configFile = "#{Rails.root}/config/soundLike-#{Rails.env}.yaml"
    @yamlConnect = YAML::load_file(@configFile)
  end

  def install
    @title = "Your Application is not configured yet. You can do it now!"
    unless File.writable?(@configFile)
      @bewareMessage = "#{@configfile} is not writable. Please fix permissions before to continue"
    end

    @titleCo = @yamlConnect.clone
    @titleCo['Sqlite3']['login'] = 'admin'
    @titleCo['Sqlite3']['password'] = md5 'admin'
    @subTitle = params['dbType']
    render layout: 'install'
  end

  def save
    data = saveParams
    yamlR = writeYaml(@configFile, data['yaml'])
    yamlUpdated = YAML::load_file(@configFile)
    db = Sqlite3.new(yamlUpdated['Sqlite3']['path'])
    if db.tableExist?('users').length == 0
      db.createUsersDB('users')
    end
    unless db.userExist?('admin')
      db.createUser(data['user'],1)
    end
    @result = db.userExist?('admin')
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
