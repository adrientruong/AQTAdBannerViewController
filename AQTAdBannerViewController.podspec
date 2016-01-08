Pod::Spec.new do |s|
  s.name     = 'AQTAdBannerViewController'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'A container view controller to display ad banners'
  s.homepage = 'https://github.com/adrientruong/AQTAdBannerViewController'
  s.authors  = { 'Adrien Truong' => 'adrien.truong@me.com' }
  s.source   = { :git => 'https://github.com/adrientruong/AQTAdBannerViewController.git', :tag => s.version }
  s.requires_arc = true
  s.source_files = 'AQTAdBannerViewController/AQTAdBannerViewController.{h,m}'
  s.ios.deployment_target = '8.0'

  s.subspec 'Core' do |core|
      core.source_files = 'AQTAdBannerViewController/AQTAdBannerViewController.{h,m}'
  end

  s.subspec 'iAd' do |iad|
    iad.source_files = 'AQTAdBannerViewController/AQTiAdBannerViewController.{h,m}'
    iad.dependency 'AQTAdBannerViewController/Core'
  end

  s.subspec 'MoPub' do |mopub|
    mopub.source_files = 'AQTAdBannerViewController/AQTMoPubAdBannerViewController.{h,m}'
    mopub.dependency 'AQTAdBannerViewController/Core'
    mopub.dependency 'mopub-ios-sdk', '~> 4.1'
  end
end
