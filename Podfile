# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'Budtender' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Budtender

pod 'MultiSlider'
pod 'Kingfisher', '~> 7.0'
pod 'Cosmos', '~> 23.0'
pod 'SideMenu'
pod 'GrowingTextView'
#pod ‘MultiStepSlider’
   pod 'IQKeyboardManagerSwift', '~> 6.5.1'
  pod 'SVProgressHUD'
   pod 'Alamofire'
   pod 'QCropper'
   pod 'GoogleSignIn'
   pod 'FBSDKLoginKit'
   pod 'FacebookCore'
   pod 'FacebookLogin'
   pod 'FacebookShare'
   pod 'Firebase/Core'
   pod 'Firebase/Auth'
   pod 'Firebase/Analytics'
   pod 'Firebase/Crashlytics'
   pod 'SDWebImage'
   pod 'BRYXBanner'
post_install do |installer|
     installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
         config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
       end
     end
   end
end
