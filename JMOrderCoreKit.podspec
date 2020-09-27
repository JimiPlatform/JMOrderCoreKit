Pod::Spec.new do |s|
  s.name = "JMOrderCoreKit"
  s.version = "1.0.8-dev"
  s.summary = "Jimi distributed DVR for iOS at CocoaPods."
  s.license = {"type"=>"Apache License 2.0", "file"=>"LICENSE"}
  s.authors = {"Eafy"=>"lizhijian_21@163.com"}
  s.homepage = "https://github.com/JimiPlatform/JMOrderCoreKit"
  s.description = "Jimi distributed DVR for iOS at CocoaPods."
  s.requires_arc = true
  #s.source = { :http => "http://10.0.10.85/apppublic/jimirepofile/raw/master/#{s.name}/#{s.name}-#{s.version}.zip?inline=false", :type => "zip" }
  s.source       = { :git => "http://10.0.10.85/app/linux/jmordercorekit.git", :tag => "#{s.version}", :branch => 'dev' }
  #s.source = { :git => "https://github.com/JimiPlatform/JMOrderCoreKit.git", :tag => "#{s.version}" }

  s.ios.deployment_target    = '8.0'
  #s.ios.vendored_framework   = 'JMOrderCoreKit.framework'
  s.dependency 'JMSmartMediaPlayer'
end

#发布命令
#pod trunk push JMOrderCoreKit.podspec --verbose --allow-warnings --use-libraries
