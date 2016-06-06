class NapiController < ApplicationController

  def default
    case params[:id]
      when "mdpGen"
        @dd = {"ss" => "dd"}
      else
        @dd={"rr"=> 'dd'}
      end
      @dd = "var to = #{@dd.to_json};"
    render 'api/def', content_type: 'application/javascript'
  end

end
