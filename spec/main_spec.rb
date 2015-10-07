describe "Application 'sr3000-auth-ios-motion'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has two window for iOS SDK 8+" do
    @app.windows.size.should == 2

    @app.windows[0].is_a? UIWindow
    @app.windows[1].is_a? UITextEffectsWindow
  end
end
