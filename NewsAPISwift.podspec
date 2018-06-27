#
# Be sure to run `pod lib lint NewsAPISwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NewsAPISwift'
  s.version          = '2.0'
  s.summary          = 'NewsAPISwift is a Swift wrapper around NewsAPI.'
  s.description      = <<-DESC
NewsAPISwift is a Swift wrapper around newsapi.org service, which provides articles from more than 70 sources.
                       DESC

  s.homepage         = 'https://github.com/lucaslimapoa/NewsAPISwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas Lima' => 'lucaslimapoa2@gmail.com' }
  s.source           = { :git => 'https://github.com/lucaslimapoa/NewsAPISwift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Source/**/*.swift'
end
