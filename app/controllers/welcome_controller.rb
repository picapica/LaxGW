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
    @label.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2]
    @label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@label)

    @defaults = NSUserDefaults.standardUserDefaults
    @login_info = UILabel.alloc.initWithFrame(CGRectZero)
    @login_info.text = "账号名：%s" % [@defaults[:login_name] || '未设置']
    @login_info.sizeToFit
    @login_info.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 + 30]
    @login_info.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@login_info)
  end

end