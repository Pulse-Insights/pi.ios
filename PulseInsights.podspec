#
# Be sure to run `pod lib lint PulseInsights.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PulseInsights'
  s.version          = '2.3.0'
  s.summary          = 'PulseInsights survey solution for iOS app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
#   PulseInsights survey solution for iOS app.
#                        DESC

  s.homepage         = 'https://pulseinsights.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author           = { 'Pulse Insights' => 'hello@pulseinsights.com' }
  s.source           = { :http => 'https://github.com/Pulse-Insights/pi.ios.git', :tag => "#{s.version}" }

  s.source_files = 'PulseInsightLibrary/*.swift'

  s.ios.deployment_target = '11.0'

  # s.resource_bundles = {
  #   'PulseInsights' => ['PulseInsights/Assets/*.png']
  # }

  s.vendored_frameworks = 'PulseInsights.framework'
  s.frameworks = 'UIKit'
  s.swift_version = '4.2'
  s.resources    = "PulseInsightLibrary/images.xcassets"
end
