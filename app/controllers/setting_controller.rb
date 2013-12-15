class SettingController < UIViewController

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Setting", image: nil, tag: 0)
    self.title = "设置"
    self
  end

  def viewDidLoad
    super

    dict = {
      "save" => "保存",
      "reload" => "恢复",
      "clear" => "清空"
    }

    self.view.backgroundColor = UIColor.whiteColor

    @defaults = NSUserDefaults.standardUserDefaults

    @label_setting = UILabel.alloc.initWithFrame(CGRectZero)
    @label_setting.text = "帐号信息"
    @label_setting.sizeToFit
    @label_setting.center = [self.view.frame.size.width / 2, 80]
    @label_setting.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@label_setting)

    @name_field = UITextField.alloc.initWithFrame([[10,200],[self.view.frame.size.width * 0.8,30]])
    @name_field.placeholder = "用户名"
    @name_field.enablesReturnKeyAutomatically = true
    @name_field.text = @defaults[:login_name] || nil
    @name_field.center = [self.view.frame.size.width / 2, @label_setting.frame.origin.y + @label_setting.frame.size.height + 30]
    self.view.addSubview(@name_field)

    @password_field = UITextField.alloc.initWithFrame([[10,200],[self.view.frame.size.width * 0.8,30]])
    @password_field.placeholder = "密码"
    @password_field.secureTextEntry = true
    @password_field.enablesReturnKeyAutomatically = true
    @password_field.text = @defaults[:login_password] || nil
    @password_field.center = [self.view.frame.size.width / 2, @label_setting.frame.origin.y + @label_setting.frame.size.height + 30 * 2]
    self.view.addSubview(@password_field)

    ["save", "clear"].each_with_index do |action_text, index|
      button_width = (self.view.frame.size.width - 80) / 2

      button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      button.setTitle(dict[action_text], forState:UIControlStateNormal)
      button.sizeToFit
      button.frame = [
        [20 + index*(button_width + 10), @password_field.frame.origin.y + button.frame.size.height + 30 * 3],
        [button_width, button.frame.size.height]
      ]
      button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
      button.addTarget(self, action:"tap_#{action_text}", forControlEvents:UIControlEventTouchUpInside)
      self.view.addSubview(button)
    end
  end

  def tap_save
    username = @name_field.text
    password = @password_field.text
    @defaults[:login_name] = username if username
    @defaults[:login_password] = password if password
    @name_field.resignFirstResponder
    @password_field.resignFirstResponder
  end

  def tap_reload
    @name_field.text = @defaults[:login_name] || nil
    @password_field.text = @defaults[:login_password] || nil
    @name_field.resignFirstResponder
    @password_field.resignFirstResponder
  end

  def tap_clear
    @name_field.text = nil
    @password_field.text = nil
    @name_field.resignFirstResponder
    @password_field.resignFirstResponder
  end

end