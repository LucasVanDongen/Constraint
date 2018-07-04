#
# Be sure to run `pod lib lint Constraint.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Constraint'
  s.version          = '0.1.3'
  s.summary          = 'Constraint is a simple Swift wrapper for iOS Auto Layout that has a very natural syntax.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Constraint is a simple Swift wrapper for iOS Auto Layout that has a very natural syntax. You can either create layouts directly using the `Constraint` class methods or use the extensions on `UIView` related classes.
                       DESC

  s.homepage         = 'https://github.com/lucasvandongen/Constraint'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lucasvandongen' => 'lucas.van.dongen@gmail.com' }
  s.source           = { :git => 'https://github.com/lucasvandongen/Constraint.git', :tag => s.version.to_s }
  s.swift_version = '4.0'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'Constraint' => ['Constraint/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
