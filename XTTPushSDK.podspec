#
# Be sure to run `pod lib lint XTTPushSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XTTPushSDK'
  s.version          = '1.0.5'
  s.summary          = 'A short description of XTTPushSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Mac-sir/XTTPushSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mac-sir' => '1018472834@qq.com' }
  s.source           = { :git => 'https://github.com/Mac-sir/XTTPushSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'XTTPushSDK/Classes/**/*'
  
  s.swift_versions = "5.0"
  # s.resource_bundles = {
  #   'XTTPushSDK' => ['XTTPushSDK/Assets/*.png']
  # }
  s.static_framework = true
  # s.public_header_files = 'XTTPushSDK/Classes/**/*'
  # s.frameworks = 'UIKit'
  # s.dependency 'MJRefresh'
  # s.vendored_frameworks = "frameworks/XTTPushSDK.framework"
  s.dependency 'Firebase/Messaging'
  s.dependency 'MQTTClient'
  s.dependency 'Alamofire'
end
