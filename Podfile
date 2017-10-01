source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'amcios' do
    pod 'Alamofire', '~> 4.5.1'
    pod 'SwiftDate', '~> 4.4.1'
    pod 'Exteptional', '~> 0.2.6'
    pod 'OneSignal', '~> 2.5.4'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
