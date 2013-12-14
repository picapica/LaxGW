class GW
  def self.login(username, password)
    url = "http://%s/cgi-bin/do_login" % ["172.16.202.201"]
    data = {
      :username => username,
      :password => password,
      :drop => 0,
      :type => 3,
      :n => 100,
      :mac => "00:00:00:00:00:00"
    }

    fire_post(url, data)
  end

  def self.logout(username, password=nil, force=false)
    if force
      url = "http://%s/cgi-bin/force_logout" % ["172.16.202.201"]
      data = {
        :username => username,
        :password => password,
        :drop => 0,
        :type => 1,
        :n => 1
      }
    else
      url = "http://%s/cgi-bin/do_logout" % ["172.16.202.201"]
      data = {:uid => username}
    end

    fire_post(url, data)
  end

  def self.fire_post(url, data)
    BW::HTTP.post(url, {payload: data}) do |response|
      if response.ok?
        App.alert(response.body.to_str)
      elsif response.status_code.to_s =~ /40\d/
        App.alert("Login failed")
      else
        App.alert(response.error_message)
      end
    end
  end
end
