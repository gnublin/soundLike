class NapiController < ApplicationController

  def default
    case params[:id]
      when "mdpGen"
		    size = 8
		    if params[:size]
					size = param[:size]
		    end
		    password = SecureRandom.urlsafe_base64(size-2)
		    mdpClear = password.gsub(/-/,'0').gsub(/_/,'4')
        mdpMd5 = md5 mdpClear
        @dd = {:clear=> mdpClear, :md5 => mdpMd5, :name => params[:name]}
      else
        @dd={"rr"=> 'dd'}
      end
      @dd = "var #{params[:id]} = #{@dd.to_json};"
    render 'api/def', content_type: 'application/javascript'
  end

end
