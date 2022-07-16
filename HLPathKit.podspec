#
# Be sure to run `pod lib lint HLPathKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HLPathKit'
  s.version          = '1.0.0'
  s.summary          = 'A short description of HLPathKit.'
  s.homepage         = 'https://github.com/hl2015222050145/HLPathKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huanglin' => 'hl2015222050145@sina.com' }
  s.source           = { :git => 'git@github.com:hl2015222050145/HLPathKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'HLPathKit/Classes/**/*.h',
  					'HLPathKit/Classes/**/*.m',
  					'HLPathKit/Classes/**/*.mm'
  s.public_header_files = 'HLPathKit/Classes/**/*.h'

end
