# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

version = '3.0.3'
timestamp = Time.now.strftime("%Y%m%d.%H")

if hash = `git show --format=%H -s` and hash.is_a?(String)
  hash = hash[1, 8]
else
  hash = 'u'
end

SHORT_VERSION = "%s " % [version]
VERSION = "%s" % [timestamp]
BNUGW_VERSION = "%s-%s-%s" % [version, timestamp, hash]

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.deployment_target = "5.0"
  app.vendor_project('vendor/NetInterface', :static)

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait]
  app.icons = ["icon-1024.png", "icon-114.png", "icon-120.png", "icon-144.png", "icon-152.png", "icon-512.png", "icon-57.png", "icon-58.png", "icon-72.png", "icon-76.png"]

  app.info_plist['NSAppTransportSecurity'] = {"NSAllowsArbitraryLoads" => true}

  app.development do
    app.name = 'LaxGW'
    app.identifier = "com.liulantao.LaxGW"
    app.version = "#{BNUGW_VERSION}-dev"
    app.provisioning_profile = "#{ENV['PROVISION_DIR'] || './mobileprovision'}/BNUGW_Development.mobileprovision"
  end

  app.release do
    app.name = 'BNUGW'
    app.identifier = "com.liulantao.BNUGW"
    app.version = "#{BNUGW_VERSION}"
    app.info_plist['CFBundleShortVersionString'] = SHORT_VERSION
    app.info_plist['CFBundleVersion'] = VERSION
    app.provisioning_profile = "#{ENV['PROVISION_DIR'] || './mobileprovision'}/BNUGW_AppStore.mobileprovision"
  end
end
