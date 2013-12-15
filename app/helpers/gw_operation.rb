class GW
  def self.login(username, password)
    url = "http://gw.bnu.edu.cn/cgi-bin/do_login"
    data = "action=login&username=%s&password=%s&type=1&n=100&is_pad=1" % [username, password]

    fire_post(url, data)
  end

  def self.logout(username=nil, password=nil, force=false)
    url = "http://gw.bnu.edu.cn/cgi-bin/do_logout?action=logout"

    fire_get(url)
  end

  def self.force_logout(username, password)
    url = "http://gw.bnu.edu.cn/cgi-bin/force_logout"
    data = "username=%s&password=%s&drop=0&type=1&n=1" % [username, password]

    fire_post(url, data)
  end

  def self.fire_get(url)
    BW::HTTP.get(url) do |response|
      if response and response.body
        App.alert(response.body.to_str)
      end
    end
  end

  def self.fire_post(url, data)
    BW::HTTP.post(url, {payload: data}) do |response|
      if response.ok?
        msg = response.body.to_str
        if (msg =~ /登录成功/)
          App.alert("登录成功")
        elsif (msg =~ /帐号的在线人数已达上限。/)
          App.alert("#{msg}请退出其它客户端或强制离线。")
        else
          App.alert(response.body.to_str)
        end
      elsif response.status_code.to_s =~ /40\d/
        App.alert("Login failed [%s]" % [response.status_code])
      else
        App.alert(response.error_message)
      end
    end
  end
end
