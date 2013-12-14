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
    @reload_text = "Reload"

    self.view.backgroundColor = UIColor.whiteColor

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self

    @data = []
    defaults = NSUserDefaults.standardUserDefaults
    login_name_info = @kvfmt % ["帐号", defaults[:login_name] || '未设置']
    @data[0] = login_name_info
    @data[1] = @kvfmt % ["外网", "正在监测..."]
  end

  def viewDidAppear(animated)
    super

    updateTableInfo(@table)
  end

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
    cell.textLabel.textAlignment = UITextAlignmentCenter if @data[indexPath.row] == @reload_text;

    cell
  end

  def updateTableInfo(table)
    data = []

    defaults = NSUserDefaults.standardUserDefaults
    login_name = defaults[:login_name] || '未设置'
    login_name_info = @kvfmt % ["帐号", login_name]
    data << login_name_info

    ifinfo = NetInterface.getInterfaceList
    ifinfo.each do |k, v|
      data << @kvfmt % [k, v]
    end

    @data = data
    table.reloadData

    conn_info = nil
    BW::HTTP.get("http://42.120.23.151/BNUGW/u/%s?v=%s&t=%d" % [[login_name].pack('m0'), App.version, Time.now.to_i]) do |response|
      conn_info = response

      if conn_info and conn_info.body
        data << @kvfmt % ["PublicIP", conn_info.body.to_str.strip]
      else
        data << @kvfmt % ["PublicIP", "-"]
      end

      data << @reload_text

      @data = data
      table.reloadData
    end
  end
end