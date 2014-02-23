class SettingController < UIViewController
  include BW::KVO

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("设置"._, image: UIImage.imageNamed("icons/32/settings-32.png"), tag: 0)
    self.title = "设置"._
    self
  end

  def viewDidLoad
    super

    @config_keys = {
      :title => "帐号信息"._,
      :login_name => "用户名"._,
      :login_password => "密码"._
    }

    self.view.backgroundColor = UIColor.whiteColor

    @right_button = UIBarButtonItem.alloc.initWithTitle("保存"._, style: UIBarButtonItemStyleBordered, target:self, action:'tap_save')
    self.navigationItem.rightBarButtonItem = @right_button

    @defaults = NSUserDefaults.standardUserDefaults

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self
    @table.delegate = self

    @data = []

    @config_keys.each do |k, v|
      @data << k
    end
  end

  # DataSource
  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    if not cell
      cell ||= UITableViewCell.alloc.initWithStyle(
        UITableViewCellStyleDefault,
        reuseIdentifier:@reuseIdentifier
      )
    end

    key = @data[indexPath.row]

    case key
    when :title
      cell.textLabel.text = @config_keys[key]
      cell.textLabel.textAlignment = UITextAlignmentCenter
    else
      field = UITextField.alloc.initWithFrame([[10,200],[self.view.frame.size.width * 0.8,30]])
      field.placeholder = @config_keys[key]
      field.secureTextEntry = true if key == :login_password
      field.enablesReturnKeyAutomatically = true
      field.text = @defaults[key] || nil
      field.textAlignment = UITextAlignmentCenter
      field.center = [self.view.frame.size.width / 2, 30]
      cell.contentView.addSubview(field)

      instance_variable_set("@field_#{key}", field)
    end

    cell
  end
  # end DataSource

  def tap_save
    username = @field_login_name.text
    password = @field_login_password.text
    @defaults[:login_name] = username if username
    @defaults[:login_password] = password if password
    @field_login_name.resignFirstResponder
    @field_login_password.resignFirstResponder
  end

end