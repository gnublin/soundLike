module ApplicationHelper

  def md5(string)
    if string =~ /^{MD5}/
      md5Pass = string
    else
      md5Pass = "{MD5}"+Digest::MD5.base64digest(string)
    end
  end

  def dbExist?(file)
    if file['connection']['sqlite3'] && file['connection']['sqlite3']['path']
      dbPath = file['connection']['sqlite3']['path']
    else
      dbPath = 'db/development.sqlite3'
    end

    if File.exist?(dbPath) 
      unless File.writable?(dbPath)
        "You don't have permission on #{dbPath}"
      end
    else
      false
    end
  end

  def dbPath(file)
    dbInfo=Hash.new
    if file['connection']['sqlite3'] && file['connection']['sqlite3']['path']
      dbInfo['sqlite3'] = file['connection']['sqlite3']['path']
    else
      dbInfo['sqlite3'] = 'db/development.sqlite3'
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

end
