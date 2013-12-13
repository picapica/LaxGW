class WelcomeController < UIViewController
  
  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("欢迎", image: nil, tag: 1)
    self
  end

  def viewDidLoad
    super

    self.title = "首页"
    self.view.backgroundColor = UIColor.whiteColor

    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "欢迎使用"
    @label.sizeToFit
    @label.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 30 * 0]
    @label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@label)

    @defaults = NSUserDefaults.standardUserDefaults
    @login_info = UILabel.alloc.initWithFrame(CGRectZero)
    @login_info.text = "账号名：%s" % [@defaults[:login_name] || '未设置']
    @login_info.sizeToFit
    @login_info.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 30 * 1]
    @login_info.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@login_info)

    @conn_info = UILabel.alloc.initWithFrame([
      [self.view.frame.size.width * 0.1, self.view.frame.size.height / 2 + 30 * 2],
      [self.view.frame.size.width * 0.8, 90]
      ])
    @conn_info.font = UIFont.systemFontOfSize(12)
    @conn_info.text = "loading..."
    @conn_info.lineBreakMode = NSLineBreakByWordWrapping
    @conn_info.frame.size.width
    @conn_info.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 30 * 2 + @conn_info.frame.size.height/2]
    @conn_info.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@conn_info)
  end

  def viewDidAppear(animated)
    super

    conn_info = nil
    BW::HTTP.get("http://42.120.23.151/BNUGW/v20131213") do |response|
      conn_info = response

      if conn_info and conn_info.body
        @conn_info.lineBreakMode = NSLineBreakByWordWrapping
        @conn_info.numberOfLines = 0
        @conn_info.text = conn_info.body.to_str
        @conn_info.sizeToFit
      else
        @conn_info.text = "没有检测到公网连接"
        @conn_info.sizeToFit
      end
    end

  end
end