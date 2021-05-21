#
# Be sure to run `pod lib lint RaveSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RaveSDK'
  s.version          = '2.2.0'
  s.summary          = 'RaveSDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Flutterwave/RaveSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'solejay' => 'segun.solaja@flutterwavego.com' }
  s.source           = { :git => 'https://github.com/Flutterwave/RaveSDK.git', :tag => s.version.to_s }
  #
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'

  s.source_files = 'RaveSDK/Classes/*/**'
  s.ios.resource_bundle = { 'RaveSDK' => 'RaveSDK/Assets/{*.png,*.json}' }
  #s.resource = 'Resources/RaveSDK.bundle'

  
  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
   s.dependency 'IQKeyboardManagerSwift'
   s.dependency 'lottie-ios'
   s.dependency 'Alamofire','5.2.1'
end
