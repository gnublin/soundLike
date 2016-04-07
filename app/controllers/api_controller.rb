class ApiController < ApplicationController

  def display
    @apiContent = {"gauth" => "test"}
    render 'api/display', content_type: 'application/javascript'
  end

end
