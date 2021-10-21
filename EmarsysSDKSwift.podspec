Pod::Spec.new do |spec|
	spec.name                 = 'EmarsysSDKSwift'
	spec.version              = '0.0.1'
	spec.homepage             = 'https://github.com/emartech/ios-emarsys-sdk-swift'
	spec.license              = 'Mozilla Public License 2.0'
    spec.author               = { 'Emarsys Technologies' => 'mobile-team@emarsys.com' }
	spec.summary              = 'Emarsys iOS SDK Swift'
	spec.platform             = :ios, '11.0'
	spec.source               = { :git => 'https://github.com/emartech/ios-emarsys-sdk-swift.git', :tag => spec.version }
	spec.source_files         = [
       'Sources/**/*.{h,m,swift}'
	]
	spec.libraries = 'z', 'c++'
end
