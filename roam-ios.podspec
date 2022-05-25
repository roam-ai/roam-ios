
Pod::Spec.new do |s|
  s.name                  = 'roam-ios'
  s.version               = '0.0.23'
  s.summary               = 'High accuracy and battery efficient location SDK for iOS by Roam.ai'
  s.homepage              = 'https://roam.ai'
  s.social_media_url      = 'https://twitter.com/roam_ai'
  s.author                = { 'Roam B.V' => 'support@roam.ai' }
  s.platform              = :ios
  s.source                = { :git => 'https://github.com/roam-ai/roam-ios.git', :tag => s.version.to_s }
  s.vendored_frameworks   = 'Roam/Roam.xcframework','Roam/AWSAuthCore.xcframework', 'Roam/AWSCognitoIdentityProvider.xcframework', 'Roam/AWSCognitoIdentityProviderASF.xcframework', 'Roam/AWSCore.xcframework','Roam/AWSIoT.xcframework','Roam/AWSMobileClientXCF.xcframework'
  s.preserve_path         = 'Roam/*'
  s.module_name           = 'Roam'
  s.ios.deployment_target = '10.0'
  s.requires_arc          = true
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.license               = { :type => 'Copyright',:text => 'Copyright (c) 2021 Roam B.V, All rights reserved.' }
end
