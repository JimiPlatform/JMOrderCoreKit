Pod::Spec.new do |s|
  s.name = "JMOrderCoreKit"
  s.version = "1.1.0"
  s.summary = "Jimi distributed DVR for iOS at CocoaPods."
  s.license = {"type"=>"Apache License 2.0", "file"=>"LICENSE"}
  s.authors = {"Eafy"=>"lizhijian@jimilab.com"}
  s.homepage = "https://github.com/JimiPlatform/JMOrderCoreKit"
  s.description = "Jimi distributed DVR for iOS at CocoaPods."
  s.requires_arc = true
  #s.source = { :http => "http://10.0.10.85/apppublic/jimirepofile/raw/master/#{s.name}/#{s.name}-#{s.version}.zip?inline=false", :type => "zip" }
  s.source = { :git => "https://github.com/JimiPlatform/JMOrderCoreKit.git", :tag => "v#{s.version}" }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'JMOrderCoreKit.framework'
  s.dependency 'JMSmartMediaPlayer', '~> 1.1.5'
  s.dependency 'JMSmartUtils', '~> 1.2.1-beta1'
end

#校验指令
#pod lib lint JMOrderCoreKit.podspec --verbose --allow-warnings --use-libraries
#发布命令
#pod trunk push JMOrderCoreKit.podspec --verbose --allow-warnings --use-libraries
