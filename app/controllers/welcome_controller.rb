class WelcomeController < UIViewController
  
  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Connection", image: nil, tag: 1)
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
  end

end