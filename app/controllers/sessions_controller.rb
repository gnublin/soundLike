class SessionsController < ApplicationController

  def initialize
    @yamlConnect = YAML::load_file("#{Rails.root}/config/soundLike-#{Rails.env}.yaml")
  end

  def login
    dbCheck = dbExist?(@yamlConnect)
    @installed = dbCheck
    unless dbCheck
      redirect_to '/install'
    else
      render 'sessions/login'
    end
  end

  def new
    if logged_in?
      redirect_to '/music'
    else
      redirect_to '/login'
    end
  end

  def create

  end

  def destroy
    if logged_in?
      log_out
      redirect_to '/login'
    end
  end

end
