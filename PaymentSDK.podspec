Pod::Spec.new do |s|
  s.name             = 'PaymentSDK'
  s.version          = '0.0.1'
  s.summary          = 'PaymentSDK summary'
 
  s.description      = <<-DESC
  PaymentSDK description
                       DESC
 
  s.homepage         = 'https://github.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PaymentSDK' => 'PaymentSDK@PaymentSDK.com' }
  s.source           = { :git => "https://github.com/llo8/PaymentSDK.git" }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/PaymentSDK/*.swift'
 
end
