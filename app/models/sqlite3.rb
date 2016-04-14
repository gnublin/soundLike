class Sqlite3
  def initialize(file)
    if file == 'default'
      configFile = "#{Rails.root}/config/soundLike-#{Rails.env}.yaml"
      yamlConnect = YAML::load_file(configFile)
      file = yamlConnect['Sqlite3']['path']
    end

    @db = SQLite3::Database.new(file)
  end

  def createUsersDB(tableName)
     @db.execute ("create table #{tableName} (login varchar(30), password varchar(16), admin bool);")
  end

  def tableExist?(tableName)
    isExist = @db.table_info(tableName)
    if isExist.empty?
      false
    else
      true
    end
  end

  def createUser(data, admin)
    fieldsName = Array.new()
    valuesData = Array.new()
    data.each do |fields, values|
     fieldsName << "#{fields}"
     valuesData << "\"#{values}\""
    end
    fieldsName << "admin"
    valuesData << admin
    @db.execute ("insert into users (#{fieldsName.join(',')}) values (#{valuesData.join(',')})")
  end

  def testCredentials(userDatas)
    username = userDatas['username']
    password = userDatas['password']
    dbPassword = @db.execute ("select password from users where login=\'#{username}\'")
    unless dbPassword.join('').match(password).nil?
       result = true
    else
       result = false
    end
  end

  def isAdmin(username)
    isAdmin = @db.execute ("select admin from users where login=\'#{username}\'")
    if isAdmin.join.to_i == 1
      "admin"
    else
      "other"
    end
  end

  def userExist?(userName)
    userExist = @db.execute ("select login from users where login=\'#{userName}\'")
     if userExist.empty?
      false
    else
      true
    end
  end

  def userList()
    dbUsersList = @db.execute ("select login from users")
    dbUsersList = dbUsersList.flatten
    tableStructure = @db.execute ('PRAGMA table_info(users);')
    tableStructureName = Array.new()
    tableStructure.each do |el|
     tableStructureName << el[1]
    end
    dbUsersListAll = Hash.new()
    dbUsersList.each do |userName|
      dbUsersListAll[userName] = Hash.new() if dbUsersListAll.dig(userName).nil?
      tableStructureName.each do |field|
        next if field == 'login'
        dbUsersListAll[userName][field] = userInfo(field, userName)
      end
    end
    return dbUsersListAll
  end

  def userInfo(field, userName)
    dbUserInfos = @db.execute ("select #{field} from users where login=\'#{userName}\'")
    dbUserInfos.flatten[0]
  end

  def query(dbName, tableName, type, query )
    case 'type'
      when 'insert'
      when 'update'
      when 'select'
    end
  end

end
