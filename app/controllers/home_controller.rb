class HomeController < UIViewController

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("HOME", image: nil, tag: 0)
    self.title = "首页"

    self
  end

  def viewDidLoad
    super

    @kvfmt = "%-10s\t%20s"
    @ops = {
      :check => "检测",
      :connect => "登入",
      :disconnect => "退出",
      :disconnect_all => "强制离线"
    }
    @ops_r = @ops.invert

    self.view.backgroundColor = UIColor.whiteColor

    @right_button = UIBarButtonItem.alloc.initWithTitle(@ops[:check], style: UIBarButtonItemStyleBordered, target:self, action:'updateTableInfo')
    self.navigationItem.rightBarButtonItem = @right_button

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self
    @table.delegate = self

    @data = []
    defaults = NSUserDefaults.standardUserDefaults
    login_name_info = @kvfmt % ["帐号", defaults[:login_name] || '未设置']
    @data[0] = login_name_info
    @data[1] = @kvfmt % ["外网", "正在监测..."]
  end

  def viewDidAppear(animated)
    super

    updateTableInfo()
  end

  # DataSource
  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
      UITableViewCellStyleDefault,
      reuseIdentifier:@reuseIdentifier
    )
    cell.textLabel.text = @data[indexPath.row]
    cell.textLabel.textAlignment = UITextAlignmentCenter if @ops.values.include?(@data[indexPath.row])
    if @data[indexPath.row] == "已连接"
      cell.textLabel.textColor = UIColor.blueColor
      cell.textLabel.textAlignment = UITextAlignmentCenter
    end

    cell
  end
  # end DataSource

  # Delegate
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    btnText = @data[indexPath.row]
    if @ops.has_value?(btnText)
      op = @ops_r[btnText]
      case op
      when :check
        updateTableInfo()

      when :connect
        defaults = NSUserDefaults.standardUserDefaults

        GW.login(defaults[:login_name], defaults[:login_password])
        sleep(1)
        updateTableInfo()

      when :disconnect
        defaults = NSUserDefaults.standardUserDefaults

        GW.logout(defaults[:login_name], defaults[:login_password])
        sleep(3)
        updateTableInfo()

      when :disconnect_all
        defaults = NSUserDefaults.standardUserDefaults

        GW.force_logout(defaults[:login_name], defaults[:login_password])
        sleep(3)
        updateTableInfo()

      else
        #puts "-%s-" % [op]
      end
    end
  end
  # end Delegate

  def updateTableInfo()
    data = []

    defaults = NSUserDefaults.standardUserDefaults
    login_name = defaults[:login_name] || '未设置'
    login_name_info = @kvfmt % ["帐号", login_name]
    data << login_name_info

    ifinfo = NetInterface.getInterfaceList
    ifinfo.each do |k, v|
      if k =~ /^en/
        data << @kvfmt % [k.gsub(/^en/, '无线'), v]
      end
    end

    data << @ops[:connect]
    data << @ops[:disconnect]
    data << @ops[:disconnect_all]

    @data = data
    @table.reloadData

    conn_info = nil
    BW::HTTP.get("http://42.120.23.151/BNUGW/u/%s?v=%s&t=%d" % [[login_name].pack('m0'), App.version, Time.now.to_i], {:timeout => 3}) do |response|
      conn_info = response

      data << ""

      if conn_info and conn_info.body
        data << "已连接"
        data << @kvfmt % ["外网地址", conn_info.body.to_str.strip]
      else
        data << "无外网IP"
        #data << response.error_message
      end
      data << Time.now.to_s

      @data = data
      @table.reloadData
    end
  end
end