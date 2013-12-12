class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    welcome_controller = WelcomeController.alloc.initWithNibName(nil, bundle: nil)
    nav_controller = UINavigationController.alloc.initWithRootViewController(welcome_controller)

    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle:nil)
    tab_controller.viewControllers = [nav_controller]

    @window.rootViewController = tab_controller

    true
  end
end
