$redis = Redis.new(:host => 'localhost', :port => 6379)
$configFileName = "#{Rails.root}/config/soundLike-#{Rails.env}.yaml"
$configFile = YAML::load_file($configFileName)

