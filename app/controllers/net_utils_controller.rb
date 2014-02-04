class NetUtilsController < UIViewController
  include BW::KVO

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("网络工具"._, image: nil, tag: 0)
    self.title = "网络工具"._
    self
  end

  def viewDidLoad
    super

    @fields = {
      :domain_field => "matrix.mib.cc"
    }

    self.view.backgroundColor = UIColor.whiteColor

    @right_button = UIBarButtonItem.alloc.initWithTitle("开始"._, style: UIBarButtonItemStyleBordered, target:self, action:'tap_start')
    self.navigationItem.rightBarButtonItem = @right_button

    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    @table.dataSource = self
    @table.delegate = self

    @data = [:domain_field]

  end

  # DataSource
  def tableView(tableView, numberOfRowsInSection: section)
    puts @data.count
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
    when :domain_field
      field = UITextField.alloc.initWithFrame([[10,200],[self.view.frame.size.width * 0.8,30]])
      #field.placeholder = key
      field.secureTextEntry = false
      field.enablesReturnKeyAutomatically = true
      field.text = @fields[:domain_field]
      field.textAlignment = UITextAlignmentCenter
      field.center = [self.view.frame.size.width / 2, 30]
      cell.contentView.addSubview(field)

      instance_variable_set("@field_#{key}", field)
    else
      cell.textLabel.text = key
      cell.textLabel.textAlignment = UITextAlignmentCenter
    end

    cell
  end
  # end DataSource

  def tap_start
    data = []
    data << :domain_field
    @field_domain_field.removeFromSuperview

    if nss = DNSUtils.getDNSServers
      nss.each do |ns|
        data << "ns:%s" % ns
      end
    end

    domain_name = @field_domain_field.text
    @fields[:domain_field] = domain_name
    result = DNSUtils.send_query(domain_name)
    unless result
      data << "no record"
      @data = data
      @table.reloadData
      @field_domain_field.resignFirstResponder
      return
    end

    result = result.shuffle
    result.each do |item|
      data << item
    end
    @data = data
    @table.reloadData

    @field_domain_field.resignFirstResponder
  end

end