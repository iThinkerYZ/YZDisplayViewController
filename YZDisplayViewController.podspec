#
#  Be sure to run `pod spec lint YZDisplayViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "YZDisplayViewController"
  s.version      = "1.0.1"
  s.summary      = "Title Bar Gradient with the User to drag for ios."
  s.homepage     = "https://github.com/iThinkerYZ"
  s.license      = "Apache"
  s.author             = { "iThinkerYZ" => "690423479@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/iThinkerYZ/YZDisplayViewController.git", :tag => "1.0.1" }

  s.source_files  =  "YZDisplayViewController/*.{h,m}"

  s.framework  = "UIKit"



end
