# Be sure to run `pod lib lint MetaheuristicKit.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = "MetaheuristicKit"
  s.version          = "0.1.0"
  s.summary          = "A collection af metaheuristic algorithm to optimize the solution of a given problem."
  s.description      = "This CocoaPod provides the ability to use metaheuristic algorithms, such as the genetic algorithm, to find a solution to a given problem."
  s.homepage         = "https://github.com/DavidPiper94/MetaheuristicKit"
  s.license          = 'MIT'
  s.author           = { "DavidPiper94" => "david.piper@udo.edu" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/MetaheuristicKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MetaheuristicKit/Classes/**/*'
  s.resource_bundles = {
    'MetaheuristicKit' => ['MetaheuristicKit/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
