class AboutController < UIViewController

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("About", image: nil, tag: 0)
    self.title = "关于"
    self
  end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    @webView = UIWebView.alloc.initWithFrame(self.view.bounds)
    loadAppInfo()
    @webView.sizeToFit
    @webView.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2]
    @webView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@webView)

    @right_button = UIBarButtonItem.alloc.initWithTitle('|<-', style: UIBarButtonItemStyleBordered, target:self, action:'loadAppInfo')
    self.navigationItem.rightBarButtonItem = @right_button
  end

  def loadAppInfo()

    text = [
      "<div align='center'>",
      "<br />" * 2,
      "北京师范大学认证网关工具",
      "版本：%s" % [App.version],
      "",
      "欢迎使用!",
      "<br />" * 3,
      "对本APP的各种意见与建议",
      "以及无情的吐槽",
      "请%s" % ['<a href="http://www.oiegg.com/forumdisplay.php?fid=190" target="_new1">戳这里</a>'],
      "",
      "对本程序猿的工作感兴趣的请%s" %['<a href="mailto:liulantao@gmail.com" target="_new2">戳这里</a>'],
      "（无节操码农接各种私活）",
      "</div>"
    ]
    textStr = text.join("<br />\n")

    @webView.loadHTMLString(textStr, baseURL: nil)
  end
end
