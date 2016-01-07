Pod::Spec.new do |s|
  s.name     = 'AQTAdBannerViewController'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'A container view controller to display ad banners'
  s.homepage = 'https://github.com/adrientruong/AQTAdBannerViewController'
  s.authors  = { 'Adrien Truong' => 'adrien.truong@me.com' }
  s.source   = { :git => 'https://github.com/adrientruong/AQTAdBannerViewController.git' }
  s.requires_arc = true
  s.source_files = 'AQTAdBannerViewController/'
  s.ios.deployment_target = '6.0'
end
