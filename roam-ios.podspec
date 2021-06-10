
Pod::Spec.new do |s|
  s.name                  = 'roam-ios'
  s.version               = '0.0.2'
  s.summary               = 'High accuracy and battery efficient location SDK for iOS by Roam.ai'
  s.homepage              = 'https://roam.ai'
  s.social_media_url      = 'https://twitter.com/roam_ai'
  s.author                = { 'Roam B.V' => 'support@roam.ai' }
  s.platform              = :ios
  s.source                = { :git => 'https://github.com/roam-ai/roam-ios.git', :tag => s.version.to_s }
  s.source_files          = 'Roam/Roam.framework/Headers/*.h'
  s.vendored_frameworks   = 'Roam/Roam.framework'
  s.module_map            = "Roam/Roam.framework/Modules/module.modulemap"
  s.module_name           = 'Roam'
  s.ios.deployment_target = '10.0'
  s.dependency 'CocoaMQTT/WebSockets','1.3.0-rc.1'
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.license               = { :type => 'Copyright',:text => 'Copyright (c) 2021 Roam B.V, All rights reserved.' }
end
