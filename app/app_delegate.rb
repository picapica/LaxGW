class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    home_controller = HomeController.alloc.initWithNibName(nil, bundle: nil)
    home_nav_controller = UINavigationController.alloc.initWithRootViewController(home_controller)

    about_controller = AboutController.alloc.initWithNibName(nil, bundle: nil)
    about_nav_controller = UINavigationController.alloc.initWithRootViewController(about_controller)

    setting_controller = SettingController.alloc.initWithNibName(nil, bundle: nil)
    setting_nav_controller = UINavigationController.alloc.initWithRootViewController(setting_controller)

    #net_utils_controller = NetUtilsController.alloc.initWithNibName(nil, bundle: nil)
    #net_utils_nav_controller = UINavigationController.alloc.initWithRootViewController(net_utils_controller)

    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle:nil)
    tab_controller.viewControllers = [home_nav_controller, setting_nav_controller, about_nav_controller]

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = tab_controller

    true
  end
end
