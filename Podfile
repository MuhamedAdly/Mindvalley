source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

def development_pods
  pod 'RxSwift', '~> 5.1'
  pod 'RxCocoa', '~> 5.1'
  pod 'Alamofire', '~> 5.2'
  pod 'Kingfisher', '~> 5.14'
  pod 'SwiftLint', '~> 0.39'
  pod 'ViewAnimator', '~> 2.7'
  pod 'DataCache', '~> 1.5'
end

def testing_pods
  pod 'Quick', '~> 2.2'
  pod 'Nimble', '9.0.0-beta.2'
  pod 'OHHTTPStubs/Swift', '~> 9.0'
end

# Pods for Channels
target 'Channels' do
  development_pods
#  testing_pods
  target 'ChannelsTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end
