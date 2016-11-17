Pod::Spec.new do |s|
  s.name         = "SKNetworkRequest"
  s.version      = "0.0.3"
  s.summary      = "A network  based on  AFNetworking 3.x+"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/shaveKevin/SKNetworkRequest"
  s.authors      = { 'shavekevin' => 'shavekevin@gmail.com' }
  s.social_media_url   = "http://www.shavekevin.com"
  s.platform     = :ios
  s.ios.deployment_target = "7.0"
  s.requires_arc = true
  s.source_files = 'SKNetworkRequest/SKNetwork.h'
  s.public_header_files = 'SKNetworkRequest/SKNetwork.h'
  s.source       = { :git => "https://github.com/shaveKevin/SKNetworkRequest.git", :tag => "0.0.3" }
  s.dependency "AFNetworking", "~> 3.1.0"
  # s.frameworks = 'UIKit', 'CoreFoundation','CoreText', 'QuartzCore', 'Accelerate', 'MobileCoreServices'
end
