#
# Be sure to run `pod lib lint Constraint.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Constraint'
  s.version          = '0.9.6'
  s.summary          = 'Constraint is a simple Swift wrapper for iOS Auto Layout that has a very natural syntax.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Constraint is a simple Swift wrapper for iOS Auto Layout that has a very natural syntax. You can either create layouts directly using the `Constraint` class methods or use the extensions on `UIView`.
                       DESC

  s.homepage         = 'https://github.com/lucasvandongen/Constraint'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lucasvandongen' => 'me@lucasvandongen.dev' }
  s.source           = { :git => 'https://github.com/lucasvandongen/Constraint.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.social_media_url = 'https://twitter.com/LucasVanDongen'

  s.platform = :ios, '9.0'

  s.source_files = 'Sources/Constraint/**/*.swift'
end
