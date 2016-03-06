Pod::Spec.new do |s|
  s.name     = 'BSTabBarController'
  s.version  = '0.0.1'
  s.summary = 'A custom tab bar controller for iOS.'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = 'https://github.com/juxingzhutou/BSTabBarController.git'
  s.author = { 'juxingzhutou' => 'juxingzhutou@gmail.com' }

  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source = { :git => "https://github.com/juxingzhutou/BSTabBarController.git", :tag => 'v0.0.1' }
  s.source_files = "BSTabBarController/*.{h,m}"
  s.public_header_files = "BSTabBarController/*.h"

  s.dependency "Masonry", "~>0.6.2"

end
