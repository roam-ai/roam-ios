
Pod::Spec.new do |s|
  s.name                  = 'roam-ios'
  s.version               = '0.2.0-beta.1'
  s.summary               = 'High accuracy and battery efficient location SDK for iOS by Roam.ai'
  s.homepage              = 'https://roam.ai'
  s.social_media_url      = 'https://twitter.com/roam_ai'
  s.author                = { 'Roam B.V' => 'support@roam.ai' }
  s.platform              = :ios
  s.source                = { :git => 'https://github.com/roam-ai/roam-ios.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.requires_arc          = true
  s.license               = { :type => 'Copyright',:text => 'Copyright (c) 2023 Roam B.V, All rights reserved.' }
  s.default_subspec = 'Roam'
    
    
 # ============================ Core Module ============================
  s.subspec 'Roam' do |core|
    core.vendored_frameworks = 'Roam/Roam.xcframework'
  end

  
# ======================= RoamGeofence Module =======================
  s.subspec 'RoamGeofence' do |geofence|
    geofence.vendored_frameworks = 'Roam/RoamGeofence.xcframework'
    geofence.dependency 'roam-ios/Roam'
  end

end
