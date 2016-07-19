module ApplicationHelper

  def md5(string)
    if string =~ /^{MD5}/
      md5Pass = string
    else
      md5Pass = "{MD5}"+Digest::MD5.base64digest(string)
    end
  end

  def dbExist?(file)
    if file['Sqlite3'] && file['Sqlite3']['path']
      dbPath = file['Sqlite3']['path']
    else
      dbPath = "db/#{Rails.env}.db"
    end

    if File.exist?(dbPath)
      unless File.writable?(dbPath)
        "You don't have permission on #{dbPath}"
      end
      true
    else
      false
    end
  end

  def dbPath(file)
    dbInfo=Hash.new
    if file['connection']['sqlite3'] && file['connection']['sqlite3']['path']
      dbInfo['sqlite3'] = file['connection']['sqlite3']['path']
    else
      dbInfo['sqlite3'] = "db/#{Rails.env}.db"
    end
    if file['connection']['ldap']
      dbInfo['ldap'] = file['connection']['ldap']
    end
    dbInfo
  end

  def writeYaml(file, content)
    path = File.dirname(file)
    if File.writable?(path)
      File.open(file, 'w') {|f| f.write content.to_yaml }
    else
      "File #{file} doesn't exist or are not writable"
    end
  end

  def errText(statusCode)
    case statusCode
    when 99
        "Login failed"
    end
  end


  def redisDefault(r_key)
    $redis.set(r_key, {'path': {'current': '/', 'base': $mp3BaseDir}, 'status': {'shuffled': false, 'repeated': false, 'activeTrack': 0, 'inProgress': 0, 'volume': 05, 'volumeMuted': false }}.to_json)
  end

end
