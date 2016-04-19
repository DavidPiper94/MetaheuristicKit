Pod::Spec.new do |s|
  s.name             = "MetaheuristicKit"
  s.version          = "0.1.0"
  s.summary          = "A collection af metaheuristic algorithm to optimize the solution of a given problem."
  s.description      = "This CocoaPod provides the ability to use metaheuristic algorithms, such as the genetic algorithm, to find a solution to a given problem."
  s.homepage         = "https://github.com/DavidPiper94/MetaheuristicKit"
  s.license          = 'MIT'
  s.author           = { "DavidPiper94" => "david.piper@udo.edu" }
  s.source           = { :git => "https://github.com/DavidPiper94/MetaheuristicKit.git", :tag => '0.1.0' }

  s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.source_files = 'MetaheuristicKit/Classes/**/*'
  s.resource_bundles = { 'MetaheuristicKit' => ['MetaheuristicKit/Assets/*.png'] }
end
