platform :ios, '10.0'
inhibit_all_warnings!

project 'NewsAPISwift.xcodeproject'

target 'Tests' do
  pod 'OHHTTPStubs/Swift', '6.1.0'
  pod 'Nimble', '7.1.2'
  pod 'Quick', '1.3.0'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
            config.build_settings['SWIFT_VERSION'] = '4.1'
        end
    end
end
