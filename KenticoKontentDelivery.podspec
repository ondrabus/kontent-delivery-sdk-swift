#
# Be sure to run `pod lib lint KenticoKontentDelivery.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KenticoKontentDelivery'
  s.version          = '2.0.0'
  s.summary          = 'Swift SDK for Kentico Kontent Delivery'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Swift SDK for Kentico Kontent Delivery.
                       DESC

  s.homepage         = 'https://github.com/kentico/kontent-delivery-sdk-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'makma' => 'martinmakarsky@gmail.com' }
  s.source           = { :git => 'https://github.com/kentico/kontent-delivery-sdk-swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kenticokontent'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KenticoKontentDelivery/Classes/**/*'
  
  s.dependency 'AlamofireObjectMapper', '~> 5.2.0'
  s.dependency 'Kanna', '~> 4.0.2'
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  
end
