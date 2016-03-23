class SoundlikeController < ApplicationController

  def not_found
      redirect_to "/notFound.html"
  end

  def music
    @t = session
    render layout: 'soundlike'
  end

end
