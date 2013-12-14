# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap/http'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BNUGW'
  app.version = 'v3-20131215'
  app.identifier = "com.liulantao.BNUGW"
  app.deployment_target = "5.0"
  app.vendor_project('vendor/NetInterface', :static)
end
