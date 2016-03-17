class Sqlite3
  def initialize(file)
    @db = SQLite3::Database.new(file)
  end

  def createUsersDB(tableName)
     @db.execute ("create table #{tableName} (login varchar(30), password varchar(16), admin bool);")
  end

  def tableExist?(tableName)
    @db.table_info(tableName)
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
    p @db.execute ("insert into users (#{fieldsName.join(',')}) values (#{valuesData.join(',')})")
  end

  def userExist?(userName)
    userExist = @db.execute ("select login from users where login=\"#{userName}\"")
    !userExist.empty?
  end



  def query(dbName, tableName, type, query )
    case 'type'
      when 'insert'
      when 'update'
      when 'select'
    end
  end

end
