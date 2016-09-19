class NapiController < ApplicationController

  def show
    err = false
    id = params[:id]

    case id
      when 'mdpGen'
		    size = 8
		    if params[:size]
		    	size = param[:size]
		    end
		    password = SecureRandom.urlsafe_base64(size-2)
		    mdpClear = password.gsub(/-/,'0').gsub(/_/,'4')
        mdpMd5 = md5 mdpClear
        @dd = {:clear=> mdpClear, :md5 => mdpMd5, :name => params[:name]}
        @dd = "var #{params[:id]} = #{@dd.to_json};"

      when 'redisGetInfo'
        ping = $redis.ping
        unless ping == "PONG"
          err=true
          session[:errMsg] = 5.0
        else
          r_key = "#{session['user_id']}-info"
          info = $redis.get(r_key)
          if info.nil?
            redis_set_base = redisDefault(r_key)
            info = $redis.get(r_key)
          end
        end
        @dd = "var redisContent = #{info};"

      when 'redisSet'
        ping = $redis.ping
        unless ping == "PONG"
          err=true
          session[:errMsg] = 5.0
        else
          r_key = "#{session['user_id']}-info"
          getInfo = $redis.get(r_key)
          r_val = params['value']
          p r_val.is_a? Hash
          r_val = JSON.parse(r_val)
          getInfo = JSON.parse(getInfo)

          p params['key']
          getInfo[params['key']] = r_val
          info = $redis.set(r_key, getInfo.to_json)
        end
        @dd = "var redisContent = '#{info}';"
      end

    unless err
      render 'api/def', content_type: 'application/javascript'
    else
      redirect_to '/music'
   end

  end
end
