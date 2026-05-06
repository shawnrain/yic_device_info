#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint yic_device_info.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'yic_device_info'
  s.version          = '0.0.1'
  s.summary          = 'Flutter device info plugin for iOS and Android.'
  s.description      = <<-DESC
  A Flutter plugin that provides device information,
  system version, model, identifier and hardware details.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'KeychainAccess', '4.2.2'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'yic_device_info_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
