Pod::Spec.new do |spec|
	spec.name                 = 'EmarsysSDKSwift'
	spec.version              = '0.0.2'
	spec.homepage             = 'https://github.com/emartech/ios-emarsys-sdk-swift'
	spec.license              = 'Mozilla Public License 2.0'
    spec.author               = { 'Emarsys Technologies' => 'mobile-team@emarsys.com' }
	spec.summary              = 'Emarsys iOS SDK Swift'
	spec.platform             = :ios, '15.0'
	spec.source               = { :git => 'https://github.com/emartech/ios-emarsys-sdk-swift.git', :tag => spec.version }
	spec.source_files         = 'ios-emarsys-sdk-swift'
	spec.swift_version        = '5.5'
    spec.dependency 'EmarsysSDKExposed'
	spec.libraries = 'z', 'c++'
end