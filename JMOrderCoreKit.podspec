Pod::Spec.new do |s|
  s.name = "JMOrderCoreKit"
  s.version = "1.1.5"
  s.summary = "Jimi distributed DVR for iOS at CocoaPods."
  s.license = {"type"=>"Apache License 2.0", "file"=>"LICENSE"}
  s.authors = {"Eafy"=>"lizhijian@jimilab.com"}
  s.homepage = "https://github.com/JimiPlatform/JMOrderCoreKit"
  s.description = "Jimi distributed DVR for iOS at CocoaPods."
  s.requires_arc = true
  s.source = { :git => "https://github.com/JimiPlatform/JMOrderCoreKit.git", :tag => "v#{s.version}" }
  #s.xcconfig = { 'VALID_ARCHS' => 'armv7 armv7s arm64 arm64e x86_64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'armv7 arm64 x86_64 i386' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'armv7 arm64 x86_64 i386' }
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'JMOrderCoreKit.framework'
  s.dependency 'JMSmartMediaPlayer'
  s.dependency 'JMSmartUtils'
  
end

#校验指令
#pod lib lint JMOrderCoreKit.podspec --verbose --allow-warnings --use-libraries
#发布命令
#pod trunk push JMOrderCoreKit.podspec --verbose --allow-warnings --use-libraries
