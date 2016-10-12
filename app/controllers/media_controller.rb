class MediaController < ApplicationController

  def show
    track = $mp3BaseDir + params[:track]
    response.headers['Content-Length'] = File.stat(track).size.to_s
    send_file track, :type => "audio/mp3", :x_sendfile => true
  end

end
