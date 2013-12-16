class AboutController < UIViewController

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("关于"._, image: nil, tag: 0)
    self.title = "关于"._
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

    textStr = "About This App"._ % [
      App.version,
      'http://www.oiegg.com/viewthread.php?tid=1703029&page=1',
      'mailto:liulantao@gmail.com'
    ]

    @webView.loadHTMLString(textStr, baseURL: nil)
  end
end
