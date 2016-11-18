Pod::Spec.new do |s|
  s.name         = "SKNetworkRequest"
  s.version      = "0.0.4"
  s.summary      = "A network  based on  AFNetworking 3.x+"
  s.description  = <<-DESC
                   网络通用
                   SKNetworkRequest
                   DESC
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/shaveKevin/SKNetworkRequest"
  s.authors      = { 'shavekevin' => 'shavekevin@gmail.com' }
  s.social_media_url   = "http://www.shavekevin.com"
  s.platform     = :ios,"7.0"
  s.requires_arc = true
  s.source_files = 'SKNetworkRequest/**/*.{h,m}'
  s.public_header_files = 'SKNetworkRequest/**/*.{h}'
  s.source       = { :git => "https://github.com/shaveKevin/SKNetworkRequest.git", :tag => "0.0.4" }
  s.dependency 'AFNetworking', '~> 3.1.0'
end
