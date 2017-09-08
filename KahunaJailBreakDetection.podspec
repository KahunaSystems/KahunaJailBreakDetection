#
# Be sure to run `pod lib lint KahunaJailBreakDetection.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KahunaJailBreakDetection'
  s.version          = '0.1.5'
  s.summary          = 'KahunaJailBreakDetection library to detect an iOS device is jailbroken or not.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KahunaJailBreakDetection library to detect an iOS device is jailbroken or not based on that apply operation in an app.
                       DESC

  s.homepage         = 'https://github.com/siddharthchopra/KahunaJailBreakDetection'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'siddharthchopra' => 'siddharth.chopra@kahunasystems.com' }
  s.source           = { :git => 'https://github.com/SiddharthChopra/KahunaJailBreakDetection.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KahunaJailBreakDetection/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KahunaJailBreakDetection' => ['KahunaJailBreakDetection/Assets/*.png']
  # }
#  s.resource_bundles    = {
#    'KahunaJailBreakDetection' => ['KahunaJailBreakDetection/*/*']
 # }
#s.resources = 'KahunaJailBreakDetection/KahunaResources.bundle'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
