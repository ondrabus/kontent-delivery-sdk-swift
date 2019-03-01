#
# Be sure to run `pod lib lint KenticoCloud.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'KenticoCloud'
    s.version          = '1.1.0'
    s.summary          = 'Swift SDK for Kentico Cloud'
    s.swift_version    = '4.0'
    
    s.description      = <<-DESC
    Swift SDK for Kentico Cloud.
    DESC
    
    s.homepage         = 'https://github.com/kentico/cloud-sdk-swift'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Martin Makarsky' => 'martinm@kentico.com' }
    s.source           = { :git => 'https://github.com/kentico/cloud-sdk-swift.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/kenticocloud'
    
    s.ios.deployment_target = '12.0'
    s.osx.deployment_target = '10.14'
    s.watchos.deployment_target = '5.0'
    s.tvos.deployment_target = '12.0.1'
    
    s.source_files = 'KenticoCloud/Classes/**/*'
    
    s.dependency 'AlamofireObjectMapper', '~> 5.2.0'
    s.dependency 'Kanna', '~> 4.0.2'
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
end
