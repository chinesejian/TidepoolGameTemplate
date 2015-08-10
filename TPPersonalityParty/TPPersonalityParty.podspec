Pod::Spec.new do |s|
  s.name             = "TPPersonalityParty"
  s.version          = "0.1.0"
  s.summary          = "TPPersonalityParty provides the classes that make the TidePool game, PersonalityParty."
  s.homepage         = "http://tidepool.co"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = "rex@interactivelabs.co"
  s.source           = { :git => "https://github.com/tidepool/TPPersonalityParty.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tidepool'
  
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  
  s.source_files = 'Classes/ios/**/*.{h,m}'
  s.resources = 'Assets/*.{game,badge}'
  s.resource_bundles = { 'personalityparty' => 'Assets/*.{png,jpg}' }
  
  s.dependency 'TPGameFramework'
  s.dependency 'RSKit', '~>0.1.8'
end
