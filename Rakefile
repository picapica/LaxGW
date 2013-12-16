# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap/http'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

version = '3'
timestamp = Time.now.strftime("%Y%m%d")

if hash = `git show --format=%H -s` and hash.is_a?(String)
  hash = hash[1, 8]
else
  hash = 'u'
end

BNUGW_VERSION = "v%s-%s-%s" % [version, timestamp, hash]

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BNUGW'
  app.identifier = "com.liulantao.BNUGW"
  app.deployment_target = "5.0"
  app.vendor_project('vendor/NetInterface', :static)
  app.interface_orientations = [:portrait]

  app.development do
    app.version = "#{BNUGW_VERSION}-dev"
    app.provisioning_profile = "#{ENV['PROVISION_DIR']}/BNUGW_Development.mobileprovision"
  end

  app.release do
    app.version = "#{BNUGW_VERSION}"
    app.provisioning_profile = "#{ENV['PROVISION_DIR']}/BNUGW_AppStore.mobileprovision"
  end
end
