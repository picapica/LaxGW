class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    welcome_controller = WelcomeController.alloc.initWithNibName(nil, bundle: nil)
    conn_nav_controller = UINavigationController.alloc.initWithRootViewController(welcome_controller)

    about_controller = AboutController.alloc.initWithNibName(nil, bundle: nil)
    about_nav_controller = UINavigationController.alloc.initWithRootViewController(about_controller)

    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle:nil)
    tab_controller.viewControllers = [conn_nav_controller, about_nav_controller]

    @window.rootViewController = tab_controller

    true
  end
end
