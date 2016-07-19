$redis = Redis.new(:host => 'localhost', :port => 6379)
$configAppFileName = "#{Rails.root}/config/soundLikeApp.yaml"
$configFileName = "#{Rails.root}/config/soundLike-#{Rails.env}.yaml"
$configAppFile = YAML::load_file($configAppFileName)
$configFile = YAML::load_file($configFileName)
$mp3BaseDir = $configAppFile['mp3BaseDir']['dir']
