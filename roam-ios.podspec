
Pod::Spec.new do |s|
  s.name                  = 'roam-ios'
  s.version               = '0.1.24'
  s.summary               = 'High accuracy and battery efficient location SDK for iOS by Roam.ai'
  s.homepage              = 'https://roam.ai'
  s.social_media_url      = 'https://twitter.com/roam_ai'
  s.author                = { 'Roam B.V' => 'support@roam.ai' }
  s.platform              = :ios
  s.source                = { :git => 'https://github.com/roam-ai/roam-ios.git', :branch => 'Modularization-MQTT' }

  s.ios.deployment_target = '12.0'
  s.requires_arc          = true
  s.license               = { :type => 'Copyright',:text => 'Copyright (c) 2023 Roam B.V, All rights reserved.' }
  
  
 # ============================ Core Module ============================
  s.subspec 'RoamCore' do |core|
    core.vendored_frameworks = 'Roam/Roam.xcframework','Roam/AWSAuthCore.xcframework', 'Roam/AWSCognitoIdentityProvider.xcframework', 'Roam/AWSCognitoIdentityProviderASF.xcframework', 'Roam/AWSCore.xcframework','Roam/AWSIoT.xcframework','Roam/AWSMobileClientXCF.xcframework'
  end
  
  # ======================== RoamMQTTConnector Module ========================
  s.subspec 'RoamMQTTConnector' do |mqtt|
      
   # Conditional inclusion of frameworks based on environment variables
   # Exclude CocoaMQTT framework if specified by environment variable
  
  if ENV['EXCLUDE_CocoaMQTT'] == 'true'
    mqtt.exclude_files = 'Roam/CocoaMQTT.xcframework'
    mqtt.vendored_frameworks = 'Roam/RoamMQTTConnector.xcframework','Roam/MqttCocoaAsyncSocket.xcframework','Roam/Starscream.xcframework'
  else
        mqtt.vendored_frameworks = 'Roam/RoamMQTTConnector.xcframework','Roam/MqttCocoaAsyncSocket.xcframework','Roam/Starscream.xcframework','Roam/CocoaMQTT.xcframework'
    end

    
  end

  # ======================= RoamBatchConnector Module =======================
  s.subspec 'RoamBatchConnector' do |batch|
    batch.vendored_frameworks = 'Roam/RoamBatchConnector.xcframework'
  end

end

