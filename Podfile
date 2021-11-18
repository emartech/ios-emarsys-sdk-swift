platform :ios, '15.0'
use_frameworks!

source 'https://github.com/emartech/pod-private.git'

target "ios-emarsys-sdk-swift" do
  if ENV["DEV"] then
    pod 'EmarsysSDKExposed', :path => '/Users/i554240/AppCodeProjects/ios-emarsys-sdk/'
  else
    pod 'EmarsysSDKExposed', :git => 'https://github.com/emartech/ios-emarsys-sdk.git', :commit => '5023d8726818687791512e97ced6d8e9b7831080'
  end
end

target "ios-emarsys-sdk-swiftTests" do
  if ENV["DEV"] then
    pod 'EmarsysSDKExposed', :path => '/Users/i554240/AppCodeProjects/ios-emarsys-sdk/'
  else
    pod 'EmarsysSDKExposed', :git => 'https://github.com/emartech/ios-emarsys-sdk.git', :commit => '5023d8726818687791512e97ced6d8e9b7831080'
  end
end

